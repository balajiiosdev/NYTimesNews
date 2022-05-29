//
//  TopNewsResponseTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import XCTest
@testable import NYTimesNewsApi

class TopNewsResponseTests: XCTestCase {

    func testTopNewsResponseParsing_ValidResponse() {
        do {
            let topNews = try parse(fileName: "top_news_valid_response.json")
            let topNewsUnwrapped = try XCTUnwrap(topNews)
            XCTAssertEqual(topNewsUnwrapped.numOfResults, 36)
            XCTAssertEqual(topNewsUnwrapped.numOfResults, topNewsUnwrapped.results.count)
            validate(topNewsUnwrapped)
        } catch let error {
            XCTFail("Test failed with \(error.localizedDescription)")
        }
    }

    func testTopNewsResponseParsing_ResponseWithNoResults() {
        do {
            let topNews = try parse(fileName: "top_news_empty_results.json")
            let topNewsUnwrapped = try XCTUnwrap(topNews)
            XCTAssertEqual(topNewsUnwrapped.numOfResults, 0, "expected 0 results")
            let message = "num_results is not same as results array count"
            XCTAssertEqual(topNewsUnwrapped.numOfResults, topNewsUnwrapped.results.count, message)
            validate(topNewsUnwrapped)
        } catch {
            XCTFail("Test failed with \(error.localizedDescription)")
        }
    }

    func testTopNewsResponseParsing_ErrorResponse() {
        do {
            _ = try parse(fileName: "error_response.json")
            XCTFail("Decoding error is expected")
        } catch let error {
            XCTAssertTrue(error is DecodingError)
        }
    }

    private func parse(fileName: String) throws -> TopNewsResponse? {
        let bundle = Bundle(for: NYTimesNewsApiTests.self)
        guard let bundlePath = bundle.url(forResource: fileName,
                                          withExtension: nil) else {
            XCTFail("\(fileName) not found")
            return nil
        }

        let data = try Data(contentsOf: bundlePath)
        let decoder = JSONDecoder()
        let topNews = try decoder.decode(TopNewsResponse.self, from: data)
        return topNews
    }

    private func validate(_ topNews: TopNewsResponse) {
        XCTAssertEqual(topNews.status, "OK")
        XCTAssertFalse(topNews.copyright.isEmpty, "copyright is empty")
        XCTAssertEqual(topNews.section, "home", "section is not home")
        XCTAssertFalse(topNews.lastUpdated.isEmpty, "lastUpdated is empty")
    }
}
