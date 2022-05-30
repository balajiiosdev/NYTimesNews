//
//  TopNewsRequest.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

struct TopNewsRequest: DataRequest, Configurable {
    var url: String
    var queryItems: [String: String]
    typealias Response = TopNewsResponse
    let section: Section
    let baseUrl: String
    let apiKey: String

    init(configuration: Configuration, section: Section = .home) {
        self.baseUrl = configuration.baseUrl
        self.apiKey = configuration.apiKey
        self.section = section
        self.url = "\(baseUrl)/svc/topstories/v2/\(section).json"
        self.queryItems = [QueryParameters.apiKey: configuration.apiKey]
    }
}
