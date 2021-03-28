//
//  ProductDetails.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import Foundation

struct ProductDetails: Decodable {

    enum CodingKeys: String, CodingKey {
        case sizes = "ModelSizes"
        case colors = "ModelColors"
    }

    let sizes: [ProductSize]
    let colors: [ProductColor]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sizes = try container.decodeIfPresent([ProductSize].self, forKey: .sizes) ?? []
        colors = try container.decodeIfPresent([ProductColor].self, forKey: .colors) ?? []
    }

    init(sizes: [ProductSize], colors: [ProductColor]) {
        self.sizes = sizes
        self.colors = colors
    }
}
