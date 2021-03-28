//
//  ProductDetailRequest.swift
//  stellamc
//
//  Created by Nicolò Pasini on 28/03/21.
//

import OSLogger
import Foundation
import NetworkManager

class ProductDetailRequest: GetRequest<ProductDetailResponse> {
    let aveKey: String = "ave"
    let pageKey: String = "page"
    let genderKey: String = "gender"
    let formatKey: String = "format"
    let sortRuleKey: String = "sortRule"
    let deparmentKey: String = "department"
    let perPageKey: String = "productsPerPage"

    init(productCode: String) {
        let host = Hosts.yoox.rawValue
        let path = "Item.API/1.0/SMC_IT/item/\(productCode).json"

        super.init(host: host, path: path)
    }

    override func validateResponse(_ response: URLResponse) -> NSError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            OSLogger.networkLog(message: "Received invalid response", access: .public, type: .debug)
            return AppError(networkError: .invalidResponse)
        }

        switch httpResponse.statusCode {
        case 200...399:
            return nil
        default:
            OSLogger.networkLog(message: "Received HTTP Response with Error code \(httpResponse.statusCode)", access: .public, type: .debug)
            return AppError(networkError: .invalidResponse)
        }
    }
}
