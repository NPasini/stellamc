//
//  String+Extensions.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}
