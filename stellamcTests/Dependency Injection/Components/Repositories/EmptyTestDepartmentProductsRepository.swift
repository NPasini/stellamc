//
//  EmptyTestDepartmentProductsRepository.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Quick
import Nimble
import ReactiveSwift

class EmptyTestDepartmentProductsRepository: DepartmentProductsRepositoryService {

    let perPageItems: Int

    init(department: Department, perPageItems: Int = 3) {
        self.perPageItems = perPageItems
    }

    func getProducts(page: Int) -> SignalProducer<[Product], NSError> {
        return SignalProducer<[Product], NSError> { (observer, lifetime) in
            observer.send(value: Array())
            observer.sendCompleted()
        }
    }
}
