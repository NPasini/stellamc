//
//  Colors.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit
import SwiftUI

extension UIColor {
    class var backGrey: UIColor {
        return UIColor(named: "BackGrey") ?? .clear
    }

    class var frontOrange: UIColor {
        return UIColor(named: "FrontOrange") ?? .clear
    }

    class var backLightGrey: UIColor {
        return UIColor(named: "BackLightGrey") ?? .clear
    }
}

extension Color {
    static let backGrey = Color(UIColor.backGrey)
    static let frontOrange = Color(UIColor.frontOrange)
    static let backLightGrey = Color(UIColor.backLightGrey)
}

