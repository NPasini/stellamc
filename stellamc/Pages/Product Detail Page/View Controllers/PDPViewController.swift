//
//  PDPViewController.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

class PDPViewController: BaseViewController {

    var pdpViewModel: PDPViewModel {
        if viewModel is PDPViewModel {
            return viewModel as! PDPViewModel
        } else {
            fatalError("The View Model has the wrong type")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        insertHostedViewController()
        setTitle("Product Details", color: UIColor.frontOrange)
    }

    // MARK: - Private Functions

    private func configureNavigationBar() {
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }

    private func insertHostedViewController() {
        let childViewController = PDPHostController(product:  pdpViewModel.product)

        childViewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(childViewController)
        view.addSubview(childViewController.view)

        NSLayoutConstraint.activate([
            childViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        childViewController.didMove(toParent: self)
    }
}
