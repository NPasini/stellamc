//
//  UITableView+Extensions.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

extension UITableView {

    /// Registers a cell type into the current tableview.
    ///
    /// - Parameter viewType: Type for the cell to be registered.
    func register<V: UITableViewCell>(viewType: V.Type) {
        register(viewType.nib(), forCellReuseIdentifier: String(describing: viewType.self))
    }
}
