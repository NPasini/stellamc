//
//  AppError.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

private let SPDomain: String = "com.stellamc"

class AppError: NSError {
    convenience init(networkError: NetworkError) {
        self.init(domain: SPDomain, code: networkError.rawValue, userInfo: [NSLocalizedDescriptionKey : String(describing: networkError)])
    }
}
