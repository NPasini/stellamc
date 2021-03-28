//
//  DepartmentProductsRequest.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import NetworkManager

class DepartmentProductsRequest: GetRequest<DepartmentProductsResponse> {
    let aveKey: String = "ave"
    let pageKey: String = "page"
    let genderKey: String = "gender"
    let formatKey: String = "format"
    let sortRuleKey: String = "sortRule"
    let deparmentKey: String = "department"
    let perPageKey: String = "productsPerPage"

    init(department: String, gender: String? = nil, page: Int, perPageItems: Int) {
        let host = "api.yoox.biz"
        let path = "Search.API/1.3/SMC_IT/search/results.json"

        var queryParameters: [String : CustomStringConvertible] = [aveKey: "prod", perPageKey: perPageItems, pageKey: page, formatKey: "lite", sortRuleKey: "Ranking", deparmentKey: department]

        if let choosenGender = gender {
            queryParameters[genderKey] = choosenGender
        }

        super.init(host: host, path: path, isHttp: true, queryParameters: queryParameters)
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
