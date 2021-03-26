//
//  MainAccessoriesRequest.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import NetworkManager

class MainAccessoriesRequest: BaseDepartmentRequest {

    init(page: Int, perPageItems: Int) {
        super.init(department: "Main_Accessories_All", gender: "D", page: page, perPageItems: perPageItems)
    }
}
