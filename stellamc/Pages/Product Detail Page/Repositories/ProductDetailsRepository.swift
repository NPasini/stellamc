//
//  ProductDetailsRepository.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift
import NetworkManager

class ProductDetailsRepository: ProductDetailsRepositoryService {

    init() { }

    func getDetails(for productCode: String) -> SignalProducer<ProductDetails, NSError> {
        let request = ProductDetailRequest(productCode: productCode)
        return observableForGetProductDetails(request)
    }

    private func observableForGetProductDetails(_ request: ProductDetailRequest) -> SignalProducer<ProductDetails, NSError> {
        return SignalProducer {
            (observer, lifetime) in

            let subscription = APIPerformer.shared.performApi(request, QoS: .default, completionQueue: .global(qos: .userInteractive)) { (result: Result<ProductDetailResponse, NSError>) in

                switch result {
                case .success(let response):
                    observer.send(value: response.details)
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


