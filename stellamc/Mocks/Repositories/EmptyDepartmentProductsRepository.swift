//
//  EmptyDepartmentProductsRepository.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import Foundation
import ReactiveSwift

class EmptyDepartmentProductsRepository: DepartmentProductsRepositoryService {

    let perPageItems: Int
    let department: Department

    init(department: Department, perPageItems: Int) {
        self.department = department
        self.perPageItems = perPageItems
    }

    func getProducts(page: Int) -> SignalProducer<[Product], NSError> {
        return SignalProducer<[Product], NSError> { (observer, lifetime) in
            observer.send(value: Array())
            observer.sendCompleted()
        }
    }
}
