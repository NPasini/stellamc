//
//  LingerieRequest.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import NetworkManager

class LingerieRequest: BaseDepartmentRequest {

    init(page: Int, perPageItems: Int) {
        super.init(department: "Main_Lingerie", page: page, perPageItems: perPageItems)
    }
}
