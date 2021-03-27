//
//  DepartmentViewControllerTests.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import UIKit
import Quick
import Nimble

class DepartmentViewControllerTests: QuickSpec {

    let perpageItems: Int = 3
    let timeout: DispatchTimeInterval = .milliseconds(300)
    let pollingTimer: DispatchTimeInterval = .milliseconds(100)
    let secondPageProducts = [MockedProducts.testProduct4, MockedProducts.testProduct5]
    let firstPageProducts = [MockedProducts.testProduct1, MockedProducts.testProduct2, MockedProducts.testProduct3]

    var presenter: UINavigationController!
    var navigationService: NavigationService?
    var viewController: DepartmentViewController!

    override func spec() {
        context("Testing the DepartmentViewController with network avaialble") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [AppServicesWithAvailableNetworkAssembly()])

                self.presenter = UINavigationController()
                self.navigationService = AssemblerWrapper.shared.resolve(NavigationService.self)

                let viewModel = DepartmentViewModel(department: .beauty, itemsPerPage: 3)
                self.navigationService?.push(page: .department, with: viewModel, using: self.presenter)
                self.viewController = self.presenter.viewControllers.first as? DepartmentViewController
            }

            describe("when is instantiated") {
                it("the UI should contain the correct initial values") {
                    expect(self.presenter.navigationBar.isHidden).to(equal(false))

                    expect(self.viewController.navigationItem.titleView).to(beAnInstanceOf(UILabel.self))
                    let titleView = self.viewController.navigationItem.titleView as! UILabel
                    expect(titleView.text).to(equal("Products"))

                    expect(self.viewController.tableView.tableFooterView).toNot(beNil())
                    expect(self.viewController.tableView.delegate).to(be(self.viewController))
                    expect(self.viewController.tableView.dataSource).to(be(self.viewController))
                    expect(self.viewController.tableView.prefetchDataSource).to(be(self.viewController))

                    expect(self.viewController.departmentViewModel.stopFetchingData.value).toEventually(equal(false), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.departmentViewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer)

                    expect(self.viewController.messageViewHeightConstraint.constant).to(equal(0))
                }
            }

            describe("when prefetching new data") {
                it("the new data should not be downoloaded when reaching a cell different from the last one") {
                    for index in 0..<self.firstPageProducts.count-1 {
                        self.viewController.tableView(self.viewController.tableView, prefetchRowsAt: [IndexPath(row: index, section: 0)])
                    }

                    expect(self.viewController.departmentViewModel.stopFetchingData.value).toEventuallyNot(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.departmentViewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer)
                }

                it("the new data should be downoloaded when reaching the last item") {
                    self.viewController.tableView(self.viewController.tableView, prefetchRowsAt: [IndexPath(row: self.firstPageProducts.count - 1, section: 0)])

                    expect(self.viewController.departmentViewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.departmentViewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts + self.secondPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer)
                }
            }

            afterEach {
                self.viewController = nil
                self.presenter.viewControllers = []

                // Check observables have been disposed and view controller has been deinited
                expect(self.viewController).to(beNil())
            }
        }

        context("Testing the DepartmentViewController with network not avaialble") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [AppServicesWithNotAvailableNetworkAssembly()])

                self.presenter = UINavigationController()
                self.navigationService = AssemblerWrapper.shared.resolve(NavigationService.self)

                let viewModel = DepartmentViewModel(department: .lingerie, itemsPerPage: 3)
                self.navigationService?.push(page: .department, with: viewModel, using: self.presenter)
                self.viewController = self.presenter.viewControllers.first as? DepartmentViewController
            }

            describe("when is instantiated") {
                it("the UI should contain the correct initial values") {
                    expect(self.presenter.navigationBar.isHidden).to(equal(false))

                    expect(self.viewController.navigationItem.titleView).to(beAnInstanceOf(UILabel.self))
                    let titleView = self.viewController.navigationItem.titleView as! UILabel
                    expect(titleView.text).to(equal("Products"))

                    expect(self.viewController.tableView.tableFooterView).toNot(beNil())
                    expect(self.viewController.tableView.delegate).to(be(self.viewController))
                    expect(self.viewController.tableView.dataSource).to(be(self.viewController))
                    expect(self.viewController.tableView.prefetchDataSource).to(be(self.viewController))

                    expect(self.viewController.departmentViewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.departmentViewModel.productsDataSource.value).toEventually(equal([]), timeout: self.timeout, pollInterval: self.pollingTimer)

                    expect(self.viewController.messageViewHeightConstraint.constant).to(beGreaterThan(0))
                    expect(self.viewController.messageLabel.text).to(equal("Network not available"))
                }
            }

            describe("when the view controller is showed") {
                it("the data should not be downoloaded") {
                    expect(self.viewController.departmentViewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer)
                    expect(self.viewController.departmentViewModel.productsDataSource.value).toEventually(equal([]), timeout: self.timeout, pollInterval: self.pollingTimer)
                }
            }

            afterEach {
                self.viewController = nil
                self.presenter.viewControllers = []

                // Check observables have been disposed and view controller has been deinited
                expect(self.viewController).to(beNil())
            }
        }
    }
}



