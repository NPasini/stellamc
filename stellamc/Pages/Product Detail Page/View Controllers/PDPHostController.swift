//
//  PDPHostController.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import SwiftUI
import Foundation

final class PDPHostController: UIHostingController<AnyView> {
//    private let displayedView: some View = MockList().environmentObject(SelectableMockManager.shared.getMockedData())

    private let productView: some View = ProductView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        rootView = AnyView(productView)
    }

    init() {
        super.init(rootView: AnyView(productView))
    }
}
