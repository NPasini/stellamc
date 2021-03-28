//
//  MockedServicesWithAvailableNetworkAssembly.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import Swinject

class MockedServicesWithAvailableNetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkMonitorService.self) { _ in return AvailableNetworkMonitor() }
        container.register(NavigationService.self) { _ in return Navigation() }.inObjectScope(.container)
        container.register(DepartmentProductsRepositoryService.self) { (_, department, perPageItems) in return MockedDepartmentProductsRepository(department: department, perPageItems: perPageItems) }
    }
}
