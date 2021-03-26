//
//  DepartmentViewModel.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift

final class DepartmentViewModel {

    let errorSignal: Property<Bool>
    let stopFetchingData: Property<Bool>
    let gazersDataSource: MutableProperty<[DepartmentProduct]>

    private var currentPage: Int
    private var isFetching: Bool
    private var errorString: String
    private let itemsPerPage: Int = 50
    private let serialDisposable: SerialDisposable
    private let errorSignalPipe: (output: VoidSignal, input: VoidSignal.Observer)
    private let stopFetchingPipe: (output: BoolSignal, input: BoolSignal.Observer)
    private let departmentProductsRepository: DepartmentProductsRepositoryService?

    // MARK: - Lyfe Cycle

    init(department: Department) {
        currentPage = 1
        errorString = ""
        isFetching = false
        errorSignalPipe = VoidSignal.pipe()
        stopFetchingPipe = BoolSignal.pipe()
        gazersDataSource = MutableProperty([])
        serialDisposable = SerialDisposable(nil)
        stopFetchingData = Property(initial: false, then: stopFetchingPipe.output)
        errorSignal = Property(initial: false, then: errorSignalPipe.output.map({ true }))
        departmentProductsRepository = AssemblerWrapper.shared.resolve(DepartmentProductsRepositoryService.self, argument: department)
    }

    deinit {
        OSLogger.dataFlowLog(message: "Disposing DepartmentViewModel", access: .public, type: .debug)

        if (!serialDisposable.isDisposed) {
            serialDisposable.dispose()
        }
    }

    //MARK: Public Functions

    func errorMessage() -> String {
        return errorString
    }

    func isValid() -> Bool {
        return true
    }

    func getProducts() {
        if (!isFetching && !stopFetchingData.value) {
            OSLogger.dataFlowLog(message: "Fetching new Department Products for page \(currentPage)", access: .public, type: .debug)
            isFetching = true

            if let repository = departmentProductsRepository {
                serialDisposable.inner = repository.getProducts(page: currentPage).on(failed: { [weak self] (error: NSError) in
                    self?.isFetching = false
                    self?.errorString = "An error occurred while retrieving data"
                    self?.stopFetchingPipe.input.send(value: true)
                    self?.errorSignalPipe.input.send(value: ())
                }, completed: { [weak self] in
                    self?.currentPage += 1
                    self?.isFetching = false
                }, value: { [weak self] (newProducts: [DepartmentProduct]) in
                    if let perPageCount = self?.itemsPerPage {
                        let endOfFetchingReachedValue = (newProducts.count < perPageCount || newProducts.count == 0) ? true : false
                        self?.stopFetchingPipe.input.send(value: endOfFetchingReachedValue)
                    }

                    OSLogger.dataFlowLog(message: "Appending \(newProducts.count) new Department Products to previous \(self?.gazersDataSource.value.count ?? 0) Products", access: .public, type: .debug)

                    self?.gazersDataSource.value.append(contentsOf: newProducts)
                }).start()
            }
        } else if (isFetching) {
            OSLogger.dataFlowLog(message: "Fetching already in progress for page \(currentPage)", access: .public, type: .debug)
        } else if (stopFetchingData.value) {
            OSLogger.dataFlowLog(message: "Fetching stopped because reached end of paged results", access: .public, type: .debug)
        }
    }
}

