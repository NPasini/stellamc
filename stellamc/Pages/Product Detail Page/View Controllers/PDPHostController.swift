//
//  PDPHostController.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import SwiftUI
import Foundation

final class PDPHostController: UIHostingController<AnyView> {
//    private let displayedView: some View = ProductView().environmentObject(SelectableMockManager.shared.getMockedData())

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        fatalError("Wrong initialization of PDPViewController")
    }

    init(product: Product) {
        let productView: some View = ProductView(product: product)
        super.init(rootView: AnyView(productView))
    }
}
