//
//  MockNetworkService.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
@testable import NYTimesNewsApi

class MockNetworkService: NetworkServiceProtocol {
    var topNewsRequest: TopNewsRequest?

    func request<Request>(_ request: Request,
                          completion: @escaping (Result<Request.Response, Error>) -> Void) where Request: DataRequest {
        self.topNewsRequest = request as? TopNewsRequest
    }
}
