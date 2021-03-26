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
    let thumbURLString: String
    let imageURLString: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        let productName = try container.decodeIfPresent(String.self, forKey: .name)
        microCategory = try container.decodeIfPresent(String.self, forKey: .microCategory)
        macroCategory = try container.decodeIfPresent(String.self, forKey: .macroCategory)

        name = productName ?? ""

        let folderId = id.prefix(2)
        let commonURL = "https://www.stellamccartney.com/\(folderId)/\(id)_"
        thumbURLString = commonURL + "8_c.jpg"
        imageURLString = commonURL + "11_c.jpg"
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return true
    }
}
