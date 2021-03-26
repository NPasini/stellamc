//
//  DepartmentResponse.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import NetworkManager

struct DepartmentResponse {
    let products: [DepartmentProduct]
}

extension DepartmentResponse: CustomDecodable {
    static func decode(_ data: Data) -> CustomDecodable? {
        let products = try? JSONDecoder().decode([DepartmentProduct].self, from: data)

        if let productsList = products {
            OSLogger.networkLog(message: "Department response contains \(productsList.count) objects", access: .public, type: .debug)
            return DepartmentResponse(products: productsList)
        } else {
            OSLogger.networkLog(message: "Decoding of Department Response was not successful", access: .public, type: .debug)
            return nil
        }
    }
}


