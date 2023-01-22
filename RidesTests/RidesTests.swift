//
//  RidesTests.swift
//  RidesTests
//
//  Created by Vish on 2023-01-22.
//

import XCTest
@testable import Rides

final class RidesTests: XCTestCase {
    
    let VM = EmissionViewModel()
    let listVC = VehicleListViewController()

    func testKmMoreThanLimit() throws {
        let result = VM.calculateEmssion(km: 6000)
        XCTAssertEqual(result, "6500.0 Unit")
    }
    
    func testKmLessThanLimit() throws{
        let result = VM.calculateEmssion(km: 4987)
        XCTAssertEqual(result, "4987.0 Unit")
    }
    
    func testTFValueMin() throws{
        let result = listVC.isValidTFValue(value: 0)
        XCTAssertFalse(result)
    }
    
    func testTFValueMax() throws{
        let result = listVC.isValidTFValue(value: 100)
        XCTAssertTrue(result)
    }
    
    func testTFValueLessThanLimit() throws{
        let result = listVC.isValidTFValue(value: 15)
        XCTAssertTrue(result)
    }
    
    func testTFValueMoreThanLimit() throws{
        let result = listVC.isValidTFValue(value: 115)
        XCTAssertFalse(result)
    }
    

    

}
