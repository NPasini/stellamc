//
//  DepartmentViewModel.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift

final class DepartmentViewModel: ViewModel {

    let errorSignal: Property<String>
    let stopFetchingData: Property<Bool>
    let productsDataSource: MutableProperty<[Product]>

    private var currentPage: Int
    private var isFetching: Bool
    private let itemsPerPage: Int = 50
    private let serialDisposable: SerialDisposable
    private let stopFetchingPipe: (output: BoolSignal, input: BoolSignal.Observer)
    private let departmentProductsRepository: DepartmentProductsRepositoryService?
    private let errorSignalPipe: (output: StringSignal, input: StringSignal.Observer)

    // MARK: - Lyfe Cycle

    init(department: Department) {
        currentPage = 1
        isFetching = false
        stopFetchingPipe = BoolSignal.pipe()
        errorSignalPipe = StringSignal.pipe()
        productsDataSource = MutableProperty([])
        serialDisposable = SerialDisposable(nil)
        errorSignal = Property(initial: "", then: errorSignalPipe.output)
        stopFetchingData = Property(initial: false, then: stopFetchingPipe.output)
        departmentProductsRepository = AssemblerWrapper.shared.resolve(DepartmentProductsRepositoryService.self, argument: department)
    }

    deinit {
        OSLogger.dataFlowLog(message: "Disposing DepartmentViewModel", access: .public, type: .debug)

        if (!serialDisposable.isDisposed) {
            serialDisposable.dispose()
        }
    }

    //MARK: Public Functions

    func getProducts() {
        if (!isFetching && !stopFetchingData.value) {
            OSLogger.dataFlowLog(message: "Fetching new Department Products for page \(currentPage)", access: .public, type: .debug)
            isFetching = true

            if let repository = departmentProductsRepository {
                serialDisposable.inner = repository.getProducts(page: currentPage).on(failed: { [weak self] (error: NSError) in
                    self?.isFetching = false
                    self?.stopFetchingPipe.input.send(value: true)
                    self?.errorSignalPipe.input.send(value: "An error occurred while retrieving data")
                }, completed: { [weak self] in
                    self?.currentPage += 1
                    self?.isFetching = false
                }, value: { [weak self] (newProducts: [Product]) in
                    if let perPageCount = self?.itemsPerPage {
                        let endOfFetchingReachedValue = (newProducts.count < perPageCount || newProducts.count == 0) ? true : false
                        self?.stopFetchingPipe.input.send(value: endOfFetchingReachedValue)
                    }

                    OSLogger.dataFlowLog(message: "Appending \(newProducts.count) new Department Products to previous \(self?.productsDataSource.value.count ?? 0) Products", access: .public, type: .debug)

                    self?.productsDataSource.value.append(contentsOf: newProducts)
                }).start()
            }
        } else if (isFetching) {
            OSLogger.dataFlowLog(message: "Fetching already in progress for page \(currentPage)", access: .public, type: .debug)
        } else if (stopFetchingData.value) {
            OSLogger.dataFlowLog(message: "Fetching stopped because reached end of paged results", access: .public, type: .debug)
        }
    }
}

