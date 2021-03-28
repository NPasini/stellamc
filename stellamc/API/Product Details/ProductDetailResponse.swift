//
//  ProductDetailResponse.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import OSLogger
import Foundation
import NetworkManager

struct ProductDetailResponse {
    let details: ProductDetails
}

extension ProductDetailResponse: CustomDecodable {
    static func decode(_ data: Data) -> CustomDecodable? {
        let productResponse = try? JSONDecoder().decode(ProductDetailsResult.self, from: data)

        if let response = productResponse {
            let productDetails = response.details
            OSLogger.networkLog(message: "Product details response succeeded", access: .public, type: .debug)
            return ProductDetailResponse(details: productDetails)
        } else {
            OSLogger.networkLog(message: "Decoding of Department Response was not successful", access: .public, type: .debug)
            return nil
        }
    }
}
