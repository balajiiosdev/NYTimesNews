//
//  MockDataRequest.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/30/22.
//

import Foundation
@testable import NYTimesNewsApi

struct MockDataRequest: DataRequest {
    var url: String = "test.com/mock"

    typealias Response = MockResponse
}

struct MockResponse: Decodable {

}
