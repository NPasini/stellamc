//
//  Page.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Foundation

enum Page {
    case pdp
    case department
    case departmentSelector

    var storyboardId: String {
        switch self {
        case .pdp, .department, .departmentSelector:
            return "Main"
        }
    }

    var identifier: String {
        switch self {
        case .pdp:
            return PDPViewController.identifier
        case .department:
            return DepartmentViewController.identifier
        case .departmentSelector:
            return DepartmentSelectorViewController.identifier
        }
    }

    func getViewController(coder: NSCoder, viewModel: ViewModel?) -> BaseViewController? {
        guard let vm = viewModel else { return nil }

        switch self {
        case .pdp:
            return PDPViewController(coder: coder, viewModel: vm)
        case .department:
            return DepartmentViewController(coder: coder, viewModel: vm)
        case .departmentSelector:
            return DepartmentSelectorViewController(coder: coder, viewModel: vm)
        }
    }
}

