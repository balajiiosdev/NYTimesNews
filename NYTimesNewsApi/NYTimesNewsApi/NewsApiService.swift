//
//  NewsApiService.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/30/22.
//

import Foundation

public protocol NewsApiService {
    func fetchTopNews(section: Section, completion: @escaping (Result<TopNewsResponse, Error>) -> Void)
}

final public class NewsApiServiceProvider: NewsApiService {
    private let networkService: NetworkServiceProtocol
    private let configuration: Configuration

    public init(configuration: Configuration) {
        self.networkService = NetworkService()
        self.configuration = configuration
    }

    init(configuration: Configuration, networkService: NetworkServiceProtocol) {
        self.configuration = configuration
        self.networkService = networkService
    }

    public func fetchTopNews(section: Section,
                             completion: @escaping (Result<TopNewsResponse, Error>) -> Void) {
        let request = TopNewsRequest(configuration: configuration, section: section)
        networkService.request(request, completion: completion)
    }
}
