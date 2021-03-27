//
//  AvailableNetworkMonitor.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import ReactiveSwift

class AvailableNetworkMonitor: NetworkMonitorService {
    var isNetworkAvailable: Property<Bool?> = Property(value: true)
}
