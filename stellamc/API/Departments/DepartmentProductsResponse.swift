//
//  DepartmentProductsResponse.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import NetworkManager

struct DepartmentProductsResponse {
    let products: [Product]
}

extension DepartmentProductsResponse: CustomDecodable {
    static func decode(_ data: Data) -> CustomDecodable? {
        let productResponse = try? JSONDecoder().decode(DepartmentResults.self, from: data)

        if let response = productResponse {
            let products = response.departmentProducts.products
            OSLogger.networkLog(message: "Department response contains \(products.count) objects", access: .public, type: .debug)
            return DepartmentProductsResponse(products: products)
        } else {
            OSLogger.networkLog(message: "Decoding of Department Response was not successful", access: .public, type: .debug)
            return nil
        }
    }
}


