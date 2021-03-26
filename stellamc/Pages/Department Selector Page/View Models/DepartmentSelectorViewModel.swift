//
//  DepartmentSelectorViewModel.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

struct DepartmentSelectorViewModel: ViewModel {

    let departments: [Department]

    init() {
        departments = [.beauty, .accessories, .lingerie, .readyToWear]
    }

    func isValid() -> Bool {
        return true
    }

    func errorMessage() -> String {
        return ""
    }
}
