//
//  AppServicesWithNotAvailableNetworkAssembly.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Swinject

class AppServicesWithNotAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return NotAvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return TestNavigation() }.inObjectScope(.container)
        container.register(DepartmentProductsRepositoryService.self) { _, department, perPageItems in
            return EmptyTestDepartmentProductsRepository(department: department, perPageItems: perPageItems)
        }
    }
}

