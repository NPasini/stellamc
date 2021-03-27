//
//  NotAvailableNetworkMonitor.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import ReactiveSwift

class NotAvailableNetworkMonitor: NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> = Property(value: false)
}
