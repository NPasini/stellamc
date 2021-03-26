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

//    var identifier: String {
//        switch self {
//        case .starGazerList:
//            return StarGazersListViewController.identifier
//        case .repositorySelector:
//            return RepositorySelectorViewController.identifier
//        }
//    }

//    func getViewController(coder: NSCoder, viewModel: ViewModel?) -> BaseViewController? {
//        guard let vm = viewModel else { return nil }
//
//        switch self {
//        case .starGazerList:
//            return StarGazersListViewController(coder: coder, viewModel: vm)
//        case .repositorySelector:
//            return RepositorySelectorViewController(coder: coder, viewModel: vm)
//        }
//    }
}

