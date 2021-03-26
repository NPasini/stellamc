//
//  ReadyToWearRequest.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import OSLogger
import Foundation
import NetworkManager

class ReadyToWearRequest: BaseDepartmentRequest {

    init(page: Int, perPageItems: Int) {
        super.init(department: "Main_Ready_To_Wear", gender: "D", page: page, perPageItems: perPageItems)
    }
}
