//
//  DepartmentProducts.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

struct DepartmentResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case results = "ResultsLite"
    }

    let departmentProducts: DepartmentProducts

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        departmentProducts = try container.decode(DepartmentProducts.self, forKey: .results)
    }
}

struct DepartmentProducts: Decodable {
    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }

    let products: [Product]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        products = try container.decode([Product].self, forKey: .items)
    }
}
