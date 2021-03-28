//
//  PDPViewModel.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import ReactiveSwift

final class PDPViewModel: ViewModel, ObservableObject {

    @Published private(set) var product: Product
    
    private let serialDisposable: SerialDisposable
    private let productDetailsRepository: ProductDetailsRepositoryService?

    init(product: Product) {
        self.product = product
        self.serialDisposable = SerialDisposable()
        self.productDetailsRepository = AssemblerWrapper.shared.resolve(ProductDetailsRepositoryService.self)

        getProductDetails()
    }

    deinit {
        OSLogger.dataFlowLog(message: "Disposing PDPViewModel", access: .public, type: .debug)

        if !serialDisposable.isDisposed {
            serialDisposable.dispose()
        }
    }

    func getProductDetails() {
        OSLogger.dataFlowLog(message: "Fetching Details for product id \(product.id)", access: .public, type: .debug)

        if let repository = productDetailsRepository {
            serialDisposable.inner = repository.getDetails(for: product.productCode).observe(on: UIScheduler()).on(failed: { [weak self] (error: NSError) in
                self?.product.setDetails(nil)
            }, value: { [weak self] (details: ProductDetails) in
                self?.product.setDetails(details)
            }).start()
        }
    }
}
