//
//  ProductColor.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import Foundation

struct ProductColor: Decodable, Hashable {

    enum CodingKeys: String, CodingKey {
        case id = "ColorId"
        case description = "ColorDescription"
    }

    let id: Int
    let description: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
    }

    init(id: Int, description: String) {
        self.id = id
        self.description = description
    }
}

extension ProductColor: Equatable {
    static func ==(lhs: ProductColor, rhs: ProductColor) -> Bool {
        return lhs.id == rhs.id
    }
}
