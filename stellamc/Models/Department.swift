//
//  Department.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

enum Department: String {
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

    var image: String {
        switch self {
        case .beauty:
            return "beauty"
        case .lingerie:
            return "lingerie"
        case .accessories:
            return "accessories"
        case .readyToWear:
            return "dress"
        }
    }

    var pathName: String {
        switch self {
        case .beauty:
            return "Main_Beauty"
        case .lingerie:
            return "Main_Lingerie"
        case .accessories:
            return "Main_Accessories_All"
        case .readyToWear:
            return "Main_Ready_To_Wear"
        }
    }

    var gender: String? {
        switch self {
        case .beauty:
            return "D"
        case .accessories:
            return "D"
        case .readyToWear:
            return "D"
        default:
            return nil
        }
    }
}
