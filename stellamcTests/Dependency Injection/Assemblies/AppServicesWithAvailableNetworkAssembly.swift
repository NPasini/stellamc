//
//  AppServicesWithAvailableNetworkAssembly.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Swinject

class AppServicesWithAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return AvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return TestNavigation() }.inObjectScope(.container)
        container.register(DepartmentProductsRepositoryService.self) { _, department, perPageItems in
            return TestDepartmentProductsRepository(department: department, perPageItems: perPageItems)
        }
    }
}
