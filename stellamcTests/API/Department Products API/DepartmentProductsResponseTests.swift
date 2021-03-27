//
//  DepartmentProductsResponseTests.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Quick
import Nimble
import Foundation

class DepartmentProductsResponseTests: QuickSpec {
    override func spec() {
        context("Testing the Department Products API response") {
            describe("should not be decoded"){
                it("with empty data"){
                    let response = DepartmentProductsResponse.decode(Data())
                    expect(response).to(beNil())
                }

                it("with a json where some of the Products have not the id"){
                    let jsonData = Json(fileName: "productsNoIds").convertToData()

                    let response = DepartmentProductsResponse.decode(jsonData)
                    expect(response).to(beNil())
                }
            }

            describe("the response should be decoded") {
                it("with correct json to parse"){
                    let jsonData = Json(fileName: "validResponse").convertToData()

                    let response = DepartmentProductsResponse.decode(jsonData)
                    expect(response).notTo(beNil())
                    expect(response).to(beAnInstanceOf(DepartmentProductsResponse.self))

                    let departmentResponse = response as! DepartmentProductsResponse
                    expect(departmentResponse.products.count).to(equal(13))

                    departmentResponse.products.forEach { (product: Product) in
                        expect(product.id).notTo(beNil())
                    }
                }
            }
        }
    }
}
