//
//  MockedDepartmentProductsRepository.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import Foundation
import ReactiveSwift

class MockedDepartmentProductsRepository: DepartmentProductsRepositoryService {

    let perPageItems: Int
    let department: Department

    init(department: Department, perPageItems: Int) {
        self.department = department
        self.perPageItems = perPageItems
    }

    func getProducts(page: Int) -> SignalProducer<[Product], NSError> {
        return SignalProducer<[Product], NSError> { [weak self] (observer, lifetime) in
            guard let weakSelf = self else { return }

            let minIndex = (page - 1)*weakSelf.perPageItems
            let maxIndex = min(page*weakSelf.perPageItems, weakSelf.allTestProducts.count)
            let pagedGazsers = weakSelf.allTestProducts[minIndex..<maxIndex]

            observer.send(value: Array(pagedGazsers))
            observer.sendCompleted()
        }
    }

    // Mocked Data
    let testProduct1 = Product(id: "id1", productCode: "1", price: 30.24, name: "Name 1", microCategory: "Micro cat 1", macroCategory: "Macro cat 1", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct2 = Product(id: "id2", productCode: "2", price: 130.24, name: "Name 2", microCategory: "Micro cat 2", macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct3 = Product(id: "id3", productCode: "3", price: 20.54, name: "Name 3", microCategory: nil, macroCategory: "Macro cat 3", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct4 = Product(id: "id4", productCode: "4", price: 5.00, name: "Name 4", microCategory: nil, macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct5 = Product(id: "id5", productCode: "5", price: 10.24, name: "Name 5", microCategory: "Micro cat 5", macroCategory: "Macro cat 5", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct6 = Product(id: "id6", productCode: "6", price: 10.24, name: "Name 6", microCategory: "Micro cat 6", macroCategory: "Macro cat 6", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct7 = Product(id: "id7", productCode: "7", price: 10.24, name: "Name 7", microCategory: "Micro cat 7", macroCategory: "Macro cat 7", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct8 = Product(id: "id8", productCode: "8", price: 10.24, name: "Name 8", microCategory: "Micro cat 8", macroCategory: "Macro cat 8", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct9 = Product(id: "id9", productCode: "9", price: 10.24, name: "Name 9", microCategory: "Micro cat 9", macroCategory: "Macro cat 9", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct10 = Product(id: "id10", productCode: "10", price: 10.24, name: "Name 10", microCategory: "Micro cat 10", macroCategory: "Macro cat 10", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct11 = Product(id: "id11",  productCode: "11", price: 30.24, name: "Name 11", microCategory: "Micro cat 11", macroCategory: "Macro cat 11", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct12 = Product(id: "id12", productCode: "12", price: 130.24, name: "Name 12", microCategory: "Micro cat 12", macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct13 = Product(id: "id13", productCode: "13", price: 20.54, name: "Name 13", microCategory: nil, macroCategory: "Macro cat 13", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct14 = Product(id: "id14", productCode: "14", price: 5.00, name: "Name 14", microCategory: nil, macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct15 = Product(id: "id15", productCode: "15", price: 10.24, name: "Name 15", microCategory: "Micro cat 15", macroCategory: "Macro cat 15", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct16 = Product(id: "id16", productCode: "16", price: 10.24, name: "Name 16", microCategory: "Micro cat 16", macroCategory: "Macro cat 16", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct17 = Product(id: "id17", productCode: "17", price: 10.24, name: "Name 17", microCategory: "Micro cat 17", macroCategory: "Macro cat 17", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct18 = Product(id: "id18", productCode: "18", price: 10.24, name: "Name 18", microCategory: "Micro cat 18", macroCategory: "Macro cat 18", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct19 = Product(id: "id19", productCode: "19", price: 10.24, name: "Name 19", microCategory: "Micro cat 19", macroCategory: "Macro cat 19", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct20 = Product(id: "id20", productCode: "20", price: 10.24, name: "Name 20", microCategory: "Micro cat 20", macroCategory: "Macro cat 20", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct21 = Product(id: "id21", productCode: "21", price: 30.24, name: "Name 21", microCategory: "Micro cat 21", macroCategory: "Macro cat 21", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct22 = Product(id: "id22", productCode: "22", price: 130.24, name: "Name 22", microCategory: "Micro cat 22", macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct23 = Product(id: "id23", productCode: "23", price: 20.54, name: "Name 23", microCategory: nil, macroCategory: "Macro cat 23", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct24 = Product(id: "id24", productCode: "24", price: 5.00, name: "Name 24", microCategory: nil, macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct25 = Product(id: "id25", productCode: "25", price: 10.24, name: "Name 25", microCategory: "Micro cat 25", macroCategory: "Macro cat 25", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct26 = Product(id: "id26", productCode: "26", price: 10.24, name: "Name 26", microCategory: "Micro cat 26", macroCategory: "Macro cat 26", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct27 = Product(id: "id27", productCode: "27", price: 10.24, name: "Name 27", microCategory: "Micro cat 27", macroCategory: "Macro cat 27", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct28 = Product(id: "id28", productCode: "28", price: 10.24, name: "Name 28", microCategory: "Micro cat 28", macroCategory: "Macro cat 28", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct29 = Product(id: "id29", productCode: "29", price: 10.24, name: "Name 29", microCategory: "Micro cat 29", macroCategory: "Macro cat 29", thumbURLString: nil, pdpImagesURLStrings: [])
    let testProduct30 = Product(id: "id30", productCode: "30", price: 10.24, name: "Name 30", microCategory: "Micro cat 30", macroCategory: "Macro cat 30", thumbURLString: nil, pdpImagesURLStrings: [])

    var allTestProducts: [Product] {
        return [testProduct1, testProduct2, testProduct3, testProduct4, testProduct5, testProduct6, testProduct7, testProduct8, testProduct9, testProduct10, testProduct11, testProduct12, testProduct13, testProduct14, testProduct15, testProduct16, testProduct17, testProduct18, testProduct19, testProduct20, testProduct21, testProduct22, testProduct23, testProduct24, testProduct25, testProduct26, testProduct27, testProduct28, testProduct29, testProduct30]
    }
}

