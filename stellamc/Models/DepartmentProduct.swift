//
//  Product.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

struct Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case price = "FullPrice"
        case name = "ModelNames"
        case id = "DefaultCode10"
        case microCategory = "MicroCategory"
        case macroCategory = "MacroCategory"
    }

    let id: String
    let price: Int
    let name: String
    let microCategory: String?
    let macroCategory: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        microCategory = try container.decodeIfPresent(String.self, forKey: .microCategory)
        macroCategory = try container.decodeIfPresent(String.self, forKey: .macroCategory)
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return true
    }
}
