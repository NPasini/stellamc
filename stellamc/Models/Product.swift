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
        case productCode = "Code8"
        case microCategory = "MicroCategory"
        case macroCategory = "MacroCategory"
    }

    let id: String
    let name: String
    let price: Double
    let productCode: String
    let thumbURLString: URL?
    let pdpImagesURLs: [URL]
    let microCategory: String?
    let macroCategory: String?
    private(set) var details: ProductDetails?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        productCode = try container.decode(String.self, forKey: .productCode)
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        let productName = try container.decodeIfPresent(String.self, forKey: .name)
        microCategory = try container.decodeIfPresent(String.self, forKey: .microCategory)
        macroCategory = try container.decodeIfPresent(String.self, forKey: .macroCategory)

        name = productName ?? ""

        let folderId = id.prefix(2)
        let commonURL = "https://www.stellamccartney.com/\(folderId)/\(id)_"
        thumbURLString = URL(string: commonURL + "8_c.jpg")

        let pdpImagesURLStrings = [commonURL + "11_c.jpg", commonURL + "11_g.jpg", commonURL + "11_h.jpg", commonURL + "11_i.jpg", commonURL + "11_p.jpg", commonURL + "11_q.jpg", commonURL + "11_s.jpg"]
        pdpImagesURLs = pdpImagesURLStrings.compactMap({ URL(string: $0) })
    }

    init(id: String, productCode: String, price: Double, name: String, microCategory: String?, macroCategory: String?, thumbURLString: URL?, pdpImagesURLStrings: [URL]) {
        self.id = id
        self.name = name
        self.price = price
        self.productCode = productCode
        self.microCategory = microCategory
        self.macroCategory = macroCategory
        self.thumbURLString = thumbURLString
        self.pdpImagesURLs = pdpImagesURLStrings
    }

    mutating func setDetails(_ details: ProductDetails?) {
        self.details = details
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
