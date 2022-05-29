//
//  MockUrlSession.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

class MockUrlSession: URLSession {
    var mockDataTask: MockUrlSessionDataTask?

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        mockDataTask?.block = completionHandler
        return mockDataTask ?? MockUrlSessionDataTask()
    }
}

typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

class MockUrlSessionDataTask: URLSessionDataTask {
    var mockSession: MockUrlSession?
    var data: Data?
    var urlResponse: URLResponse?
    var httpError: NSError?
    var block: CompletionHandler?
    var request: URLRequest?
    var resumeCalledCount = 0

    override var response: URLResponse? {
        urlResponse
    }

    init(data: Data? = nil,
         request: URLRequest? = nil,
         urlResponse: URLResponse? = nil,
         httpError: NSError? = nil,
         completionHandler: CompletionHandler? = nil) {
        self.mockSession = nil
        self.data = data
        self.urlResponse = urlResponse
        self.httpError = httpError
        self.block = completionHandler
        self.request = request
    }

    override public func resume() {
        resumeCalledCount += 1
        block?(data, urlResponse, httpError)
    }
}
