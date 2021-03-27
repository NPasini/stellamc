//
//  MockedServicesWithNotAvailableNetworkAssembly.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import Swinject

class MockedServicesWithNotAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return NotAvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return Navigation() }.inObjectScope(.container)
        container.register(DepartmentProductsRepositoryService.self) { (_, department, perPageItems) in return EmptyDepartmentProductsRepository(department: department, perPageItems: perPageItems) }
    }
}
