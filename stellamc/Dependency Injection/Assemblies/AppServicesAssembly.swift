//
//  AppServicesAssembly.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Swinject

class AppServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NavigationService.self) { _ in return Navigation() }.inObjectScope(.container)
        container.register(NetworkMonitorService.self) { _ in return NetworkMonitor() }.inObjectScope(.container)
    }
}

