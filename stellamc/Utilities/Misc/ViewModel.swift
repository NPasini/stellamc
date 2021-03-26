//
//  ViewModel.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

protocol ViewModel {
    func isValid() -> Bool
    func errorMessage() -> String
}
