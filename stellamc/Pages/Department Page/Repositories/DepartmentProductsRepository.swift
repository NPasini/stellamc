//
//  DepartmentProductsRepository.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift
import NetworkManager

class DepartmentProductsRepository: DepartmentProductsRepositoryService {

    let department: Department

    init(department: Department) {
        self.department = department
    }

    func getProducts(page: Int) -> SignalProducer<[DepartmentProduct], NSError> {
        let request = DepartmentProductsRequest(department: department.pathName, gender: department.gender, page: page, perPageItems: 50)
        return observableForGetGazers(request)
    }

    private func observableForGetGazers(_ request: DepartmentProductsRequest) -> SignalProducer<[DepartmentProduct], NSError> {
        return SignalProducer {
            (observer, lifetime) in

            let subscription = APIPerformer.shared.performApi(request, QoS: .default, completionQueue: .global(qos: .userInteractive)) { (result: Result<DepartmentResponse, NSError>) in

                switch result {
                case .success(let response):
                    observer.send(value: response.products)
                case .failure(let error):
                    observer.send(error: error)
                }

                observer.sendCompleted()
            }

            lifetime.observeEnded {
                subscription.dispose()
            }
        }
    }
}

