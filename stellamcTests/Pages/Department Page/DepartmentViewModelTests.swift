//
//  DepartmentViewModelTests.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Quick
import Nimble
import ReactiveSwift

class DepartmentViewModelTests: QuickSpec {

    let perpageItems: Int = 3
    let timeout: DispatchTimeInterval = .milliseconds(300)
    let pollingTimer: DispatchTimeInterval = .milliseconds(100)
    let secondPageProducts = [MockedProducts.testProduct4, MockedProducts.testProduct5]
    let firstPageProducts = [MockedProducts.testProduct1, MockedProducts.testProduct2, MockedProducts.testProduct3]

    var viewModel: DepartmentViewModel!

    override func spec() {
        context("Testing the DepartmentViewModel") {
            beforeEach {
                AssemblerWrapper.shared.register(assemblies: [AppServicesWithAvailableNetworkAssembly()])

                self.viewModel = DepartmentViewModel(department: .beauty, itemsPerPage: self.perpageItems)
            }

            describe("when is instantiated") {
                it("should contain the default values") {
                    expect(self.viewModel.productsDataSource.value).to(equal([]))
                    expect(self.viewModel.stopFetchingData.value).to(equal(false))
                }
            }

            describe("when requesting the department products") {
                it("the datasource should be updated correctly") {
                    self.viewModel.getProducts()

                    expect(self.viewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                    expect(self.viewModel.stopFetchingData.value).toEventually(equal(false), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                }

                it("should signal to stop loading when reached the end of the content") {
                    self.viewModel.getProducts()

                    // Wait first page data from repository are retrieved
                    expect(self.viewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)

                    self.viewModel.getProducts()

                    expect(self.viewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts + self.secondPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                    expect(self.viewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                }

                it("should do nothing when asking for new data once there are no more products") {
                    self.viewModel.getProducts()

                    // Wait first page data from repository are retrieved
                    expect(self.viewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)

                    self.viewModel.getProducts()

                    // Wait second page data from repository are retrieved
                    expect(self.viewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts + self.secondPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)

                    self.viewModel.getProducts()

                    // Wait third page data from repository are retrieved
                    expect(self.viewModel.productsDataSource.value).toEventually(equal(self.firstPageProducts + self.secondPageProducts), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                    expect(self.viewModel.stopFetchingData.value).toEventually(equal(true), timeout: self.timeout, pollInterval: self.pollingTimer, description: nil)
                }
            }
        }
    }
}

