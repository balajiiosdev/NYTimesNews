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
        let session = mockUrlSession(url: url, statusCode: 200, data: data)
        let sut = NetworkService(session: session)

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

    func testRequest_HttpError401() throws {
        let request = TopNewsRequest()
        let expectation = self.expectation(description: "Http error 401 scenario")
        guard let mockResponseUrl = url(for: MockDataFileNames.errorResponse) else {
            XCTFail("\(MockDataFileNames.errorResponse) is not found")
            return
        }
        let data = try Data(contentsOf: mockResponseUrl)
        guard let url = URL(string: request.url) else {
            XCTFail("TopNewsRequest URL is nil")
            return
        }
        let session = mockUrlSession(url: url, statusCode: 401, data: data)
        let sut = NetworkService(session: session)

        sut.request(request) { result in
            switch result {
            case .success(_):
               XCTFail("Success is not expected")
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.code, 401)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testRequest_FailedWith_NSURLErrorTimedOut() {
        let request = TopNewsRequest()
        let expectation = self.expectation(description: "NSURLErrorTimedOut scenario")

        guard let url = URL(string: request.url) else {
            XCTFail("TopNewsRequest URL is nil")
            return
        }
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        let session = mockUrlSession(url: url, statusCode: 0, error: error)
        let sut = NetworkService(session: session)

        sut.request(request) { result in
            switch result {
            case .success(_):
               XCTFail("Success is not expected")
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.code, NSURLErrorTimedOut)
                XCTAssertEqual(nsError.domain, NSURLErrorDomain)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testRequest_FailedWithParsingError() throws {
        let request = TopNewsRequest()
        let expectation = self.expectation(description: "Parsing Error scenario")
        guard let mockResponseUrl = url(for: MockDataFileNames.errorResponse) else {
            XCTFail("\(MockDataFileNames.errorResponse) is not found")
            return
        }
        let data = try Data(contentsOf: mockResponseUrl)
        guard let url = URL(string: request.url) else {
            XCTFail("TopNewsRequest URL is nil")
            return
        }
        let session = mockUrlSession(url: url, statusCode: 200, data: data)
        let sut = NetworkService(session: session)

        sut.request(request) { result in
            switch result {
            case .success(_):
                XCTFail("Success is not expected")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testRequest_FailedToBuildUrlWithMalformedUrl() {
        let request = TopNewsRequest(url: "\\ewrewre")
        let expectation = self.expectation(description: "URL Error scenario")
        let sut = NetworkService()

        sut.request(request) { result in
            switch result {
            case .success(_):
                XCTFail("Success is not expected")
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.code, 404)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    private func mockUrlSession(url: URL, statusCode: Int, data: Data? = nil, error: NSError? = nil) -> MockUrlSession {
        let urlResponse =  HTTPURLResponse(url: url,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
        let mockUrlSession = MockUrlSession()
        let dataTask = MockUrlSessionDataTask(data: data,
                                              request: nil,
                                              urlResponse: urlResponse,
                                              httpError: error,
                                              completionHandler: nil)
        mockUrlSession.mockDataTask = dataTask
        return mockUrlSession
    }
}
