//
//  NetworkServiceTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import XCTest
@testable import NYTimesNewsApi

class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut =  NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRequest_SuccessfulScenario() {
        let request = TopNewsRequest()
        let expectation = self.expectation(description: "Successful scenario")

        sut.request(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.status, "OK")
            case .failure(let error):
                XCTFail("Failure is not expected, \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
