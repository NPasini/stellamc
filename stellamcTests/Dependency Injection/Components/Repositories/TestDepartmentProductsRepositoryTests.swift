//
//  TestDepartmentProductsRepositoryTests.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Quick
import Nimble
import ReactiveSwift

class TestDepartmentProductsRepository: DepartmentProductsRepositoryService {

    let perPageItems: Int

    init(department: Department, perPageItems: Int = 3) {
        self.perPageItems = perPageItems
    }

    func getProducts(page: Int) -> SignalProducer<[Product], NSError> {
        return SignalProducer<[Product], NSError> { [weak self] (observer, lifetime) in
            guard let weakSelf = self else { return }

            let minIndex = (page - 1)*weakSelf.perPageItems
            let maxIndex = min(page*weakSelf.perPageItems, MockedProducts.allProducts.count)
            let pagedProducts = MockedProducts.allProducts[minIndex..<maxIndex]

            observer.send(value: Array(pagedProducts))
            observer.sendCompleted()
        }
    }
}
