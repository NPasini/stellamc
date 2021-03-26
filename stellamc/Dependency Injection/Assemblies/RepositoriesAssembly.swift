//
//  RepositoriesAssembly.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import Swinject
import Foundation

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {

        container.register(DepartmentProductsRepositoryService.self) { _, department in
            return DepartmentProductsRepository(department: department)
        }

        container.register(DepartmentProductsRepositoryService.self) { _, department, perPageItems in
            return DepartmentProductsRepository(department: department, perPageItems: perPageItems)
        }
    }
}
