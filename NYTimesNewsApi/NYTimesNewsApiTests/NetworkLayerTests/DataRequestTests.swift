//
//  DataRequestTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/30/22.
//

import XCTest
@testable import NYTimesNewsApi

class DataRequestTests: XCTestCase {
    var sut: MockDataRequest!

    override func setUp() {
        super.setUp()

        sut = MockDataRequest()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMethod() {
        XCTAssertEqual(sut.method, .get, "Default method is not get")
    }

    func testHeaders() {
        XCTAssertTrue(sut.headers.isEmpty, "By default headers are not empty")
    }

    func testQueryParameters() {
        XCTAssertTrue(sut.queryItems.isEmpty, "By default query parameters are not empty")
    }
}
