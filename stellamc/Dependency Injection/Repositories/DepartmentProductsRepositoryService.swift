//
//  DepartmentProductsRepositoryService.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation
import ReactiveSwift

protocol DepartmentProductsRepositoryService {
    func getProducts(page: Int) -> SignalProducer<[Product], NSError>
}

extension DepartmentProductsRepositoryService {
    func getProducts(page: Int = 1) -> SignalProducer<[Product], NSError> {
        getProducts(page: 1)
    }
}
