//
//  ProductDetailsRepositoryService.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import Foundation
import ReactiveSwift

protocol ProductDetailsRepositoryService {
    func getDetails(for productCode: String) -> SignalProducer<ProductDetails, NSError>
}
