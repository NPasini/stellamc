//
//  NetworkMonitorService.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import ReactiveSwift

protocol NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> { get }
}
