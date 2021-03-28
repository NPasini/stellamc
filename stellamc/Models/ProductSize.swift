//
//  ProductSize.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

struct ProductSize: Decodable, Hashable {

    enum CodingKeys: String, CodingKey {
        case id = "SizeId"
        case details = "Default"
    }

    enum NestedKeys: String, CodingKey {
        case name = "Text"
    }

    let id: Int
    let description: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)

        let nestedContainer = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .details)
        description = try nestedContainer.decode(String.self, forKey: .name)
    }

    init(id: Int, description: String) {
        self.id = id
        self.description = description
    }
}

extension ProductSize: Equatable {
    static func ==(lhs: ProductSize, rhs: ProductSize) -> Bool {
        return lhs.id == rhs.id
    }
}

