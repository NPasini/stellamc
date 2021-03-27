//
//  SceneDelegate+UITests.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

extension SceneDelegate {
    func createViewControllerForTesting(using navigationService: NavigationService?, presenter: UINavigationController) {

        var page: Page?
        var viewModel: ViewModel?

        guard let testPage = ProcessInfo.processInfo.environment["testPage"] else { return }

        switch testPage {
        case "department":
            page = .department
            viewModel = DepartmentViewModel(department: .beauty, itemsPerPage: 15)
        default: ()
        }

        if let selectedPage = page, let navigation = navigationService {
            navigation.push(page: selectedPage, with: viewModel, using: presenter, animated: false)
        }
    }
}

