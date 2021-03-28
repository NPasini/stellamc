//
//  DepartmentProductsRequestTests.swift
//  stellamcTests
//
//  Created by Nicolò Pasini on 27/03/21.
//

@testable import stellamc

import Quick
import Nimble
import Foundation

class DepartmentProductsRequestTests: QuickSpec {
    private let page: Int = 1
    private let perPageItems: Int = 25

    override func spec() {
        context("Testing the Department Products API request"){
            describe("when is created for the beauty department"){
                it("should contain correct endpoint and parameters"){
                    let request = DepartmentProductsRequest(department: Department.beauty.pathName, gender: Department.beauty.gender, page: self.page, perPageItems: self.perPageItems)
                    self.testRequest(request, for: Department.beauty)
                }
            }

            describe("when is created for the ready to wear department"){
                it("should contain correct endpoint and parameters"){
                    let request = DepartmentProductsRequest(department: Department.readyToWear.pathName, gender: Department.readyToWear.gender, page: self.page, perPageItems: self.perPageItems)
                    self.testRequest(request, for: Department.readyToWear)
                }
            }

            describe("when is created for the lingerie department"){
                it("should contain correct endpoint and parameters"){
                    let request = DepartmentProductsRequest(department: Department.lingerie.pathName, gender: Department.lingerie.gender, page: self.page, perPageItems: self.perPageItems)
                    self.testRequest(request, for: Department.lingerie)
                }
            }

            describe("when is created for the accessories department"){
                it("should contain correct endpoint and parameters"){
                    let request = DepartmentProductsRequest(department: Department.accessories.pathName, gender: Department.accessories.gender, page: self.page, perPageItems: self.perPageItems)
                    self.testRequest(request, for: Department.accessories)
                }
            }
        }
    }

    private func testRequest(_ request: DepartmentProductsRequest, for department: Department) {
        expect(request.host).to(equal("api.yoox.biz"))
        expect(request.version).to(beNil())
        expect(request.isHttp).to(be(true))
        expect(request.path).to(equal("Search.API/1.3/SMC_IT/search/results.json"))
        expect(request.queryParameters).notTo(beNil())

        if let pageParameter = request.queryParameters?[request.pageKey] as? Int {
            expect(pageParameter).to(equal(self.page))
        } else {
            fail("Page parameter not present")
        }

        if let perPageParameter = request.queryParameters?[request.perPageKey] as? Int {
            expect(perPageParameter).to(equal(self.perPageItems))
        } else {
            fail("Per page parameter not present")
        }

        if let perPageParameter = request.queryParameters?[request.aveKey] as? String {
            expect(perPageParameter).to(equal("prod"))
        } else {
            fail("Ave parameter not present")
        }

        if let gender = department.gender {
            if let perPageParameter = request.queryParameters?[request.genderKey] as? String {
                expect(perPageParameter).to(equal(gender))
            } else {
                fail("Gender parameter not present")
            }
        }

        if let perPageParameter = request.queryParameters?[request.formatKey] as? String {
            expect(perPageParameter).to(equal("lite"))
        } else {
            fail("Format parameter not present")
        }

        if let perPageParameter = request.queryParameters?[request.sortRuleKey] as? String {
            expect(perPageParameter).to(equal("Ranking"))
        } else {
            fail("Sort parameter not present")
        }

        if let perPageParameter = request.queryParameters?[request.deparmentKey] as? String {
            expect(perPageParameter).to(equal(department.pathName))
        } else {
            fail("Deparment parameter not present")
        }
    }
}


