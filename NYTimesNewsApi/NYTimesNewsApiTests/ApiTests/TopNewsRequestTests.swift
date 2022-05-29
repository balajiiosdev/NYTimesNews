//
//  TopNewsRequestTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import XCTest
@testable import NYTimesNewsApi

class TopNewsRequestTests: XCTestCase {
    var sut: TopNewsRequest!

    override func setUp() {
        super.setUp()

        sut = TopNewsRequest()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testHTTPMethod() {
        XCTAssertEqual(sut.method, HTTPMethod.get)
    }

    func testUrl() {
        let url = sut.url

        XCTAssertEqual(url, "https://api.nytimes.com/svc/topstories/v2/home.json")
    }

    func testHeaders() {
        XCTAssertTrue(sut.headers.isEmpty)
    }

    func testQueryParameters() {
        XCTAssertTrue(sut.queryItems.isEmpty)
    }

    func testDecode() throws {
        let url = try XCTUnwrap(url(for: "top_news_valid_response.json"))
        let data = try Data(contentsOf: url)
        let response = try sut.decode(data)

        XCTAssertEqual(response.status, "OK")
        XCTAssertEqual(response.numOfResults, 36)
        XCTAssertEqual(response.results.count, 36)
    }

    func testDecode_WithErrorResponse() {
        do {
            let url = try XCTUnwrap(url(for: "error_response.json"))
            let data = try Data(contentsOf: url)

            _ = try sut.decode(data)
            XCTFail("Error is exptected")
        } catch let error {
            XCTAssertTrue(error is DecodingError)
        }
    }
}