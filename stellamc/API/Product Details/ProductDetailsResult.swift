//
//  ProductDetailsResult.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import Foundation

struct ProductDetailsResult: Decodable {

    enum CodingKeys: String, CodingKey {
        case data = "Item"
    }

    let details: ProductDetails

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        details = try container.decode(ProductDetails.self, forKey: .data)
    }

    init(details: ProductDetails) {
        self.details = details
    }
}
