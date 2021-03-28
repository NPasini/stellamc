//
//  MockedProducts.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

struct MockedProducts {
    static let testProduct1 = Product(id: "id1", price: 30.24, name: "Name 1", microCategory: "Micro cat 1", macroCategory: "Macro cat 1", thumbURLString: nil, pdpImagesURLStrings: [])
    static let testProduct2 = Product(id: "id2", price: 130.24, name: "Name 2", microCategory: "Micro cat 2", macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    static let testProduct3 = Product(id: "id3", price: 20.54, name: "Name 3", microCategory: nil, macroCategory: "Macro cat 3", thumbURLString: nil, pdpImagesURLStrings: [])
    static let testProduct4 = Product(id: "id4", price: 5.00, name: "Name 4", microCategory: nil, macroCategory: nil, thumbURLString: nil, pdpImagesURLStrings: [])
    static let testProduct5 = Product(id: "id5", price: 10.24, name: "Name 5", microCategory: "Micro cat 5", macroCategory: "Macro cat 5", thumbURLString: nil, pdpImagesURLStrings: [])

    static let allProducts = [testProduct1, testProduct2, testProduct3, testProduct4, testProduct5]
}
