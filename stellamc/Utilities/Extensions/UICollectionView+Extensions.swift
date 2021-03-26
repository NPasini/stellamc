//
//  UICollectionView+Extensions.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

extension UICollectionView {

    /// Registers a cell type into the current tableview.
    ///
    /// - Parameter viewType: Type for the cell to be registered.
    func register<V: UICollectionViewCell>(viewType: V.Type) {
        register(viewType.nib(), forCellWithReuseIdentifier: String(describing: viewType.self))
    }
}
