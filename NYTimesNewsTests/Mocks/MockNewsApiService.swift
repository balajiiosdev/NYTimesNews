//
//  MockNewsApiService.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import Foundation
import NYTimesNewsApi
import XCTest

enum MockDataFileNames {
    static let topNewsValidResponse = "top_news_valid_response.json"
}

enum MockDataError: Error {
    case fileNotFound
    case parsingError
}

class MockNewsApiService: NewsApiService {
    var section: Section?
    var fetchTopNewsCalledCount = 0
    var expectation: XCTestExpectation?
    var topNewsError: Error?

    func fetchTopNews(section: Section, completion: @escaping (Result<TopNewsResponse, Error>) -> Void) {
        fetchTopNewsCalledCount += 1
        self.section = section
        defer {
            expectation?.fulfill()
        }
        guard let fileUrl = url(for: MockDataFileNames.topNewsValidResponse) else {
            completion(.failure(MockDataError.fileNotFound))
            return
        }
        guard topNewsError == nil else {
            completion(.failure(topNewsError!))
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let response = try decoder.decode(TopNewsResponse.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(MockDataError.parsingError))
        }
    }

    private func url(for fileName: String) -> URL? {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: fileName,
                                   withExtension: nil) else {
            return nil
        }
        return url
    }
}
