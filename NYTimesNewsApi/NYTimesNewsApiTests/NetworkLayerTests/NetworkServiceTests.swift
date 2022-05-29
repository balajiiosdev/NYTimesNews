//
//  NetworkServiceTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import XCTest
@testable import NYTimesNewsApi

class NetworkServiceTests: XCTestCase {
    func testRequest_SuccessfulScenario() throws {
        let request = TopNewsRequest()
        let expectation = self.expectation(description: "Successful scenario")
        guard let mockResponseUrl = url(for: MockDataFileNames.topNewsValidResponse) else {
            XCTFail("\(MockDataFileNames.topNewsValidResponse) is not found")
            return
        }
        let data = try Data(contentsOf: mockResponseUrl)
        guard let url = URL(string: request.url) else {
            XCTFail("TopNewsRequest URL is nil")
            return
        }
        let urlResponse =  HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        let mockUrlSession = MockUrlSession()
        let dataTask = MockUrlSessionDataTask(data: data,
                                                    request: nil,
                                                    urlResponse: urlResponse,
                                                    httpError: nil,
                                                    completionHandler: nil)
        mockUrlSession.mockDataTask = dataTask
        let sut = NetworkService(session: mockUrlSession)

        sut.request(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.status, "OK")
                XCTAssertEqual(response.numOfResults, 36)
            case .failure(let error):
                XCTFail("Failure is not expected, \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
