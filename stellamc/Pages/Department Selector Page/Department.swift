//
//  Department.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

enum Department {
    case beauty
    case lingerie
    case accessories
    case readyToWear

    var name: String {
        switch self {
        case .beauty:
            return "Beauty"
        case .lingerie:
            return "Lingerie"
        case .accessories:
            return "Accessories"
        case .readyToWear:
            return "Ready to wear"
        }
    }
}
