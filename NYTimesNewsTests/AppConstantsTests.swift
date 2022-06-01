//
//  AppConstantsTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import XCTest
@testable import NYTimesNews

class AppConstantsTests: XCTestCase {
    func testBaseUrl() {
        XCTAssertEqual(AppConstants.baseUrl, "https://api.nytimes.com")
    }

    func testAPIKey() {
        XCTAssertEqual(AppConstants.apiKey, "lbNOuDgIEvPAa6VH7mKTw9CtegLZSdnW")
    }
}
