//
//  TopNewsRequest.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

struct TopNewsRequest: DataRequest, Configurable {
    var url: String = "https://api.nytimes.com/svc/topstories/v2/home.json"
    var queryItems: [String: String] = ["apiKey": "12345"]
    typealias Response = TopNewsResponse
    let section: Section
    let baseUrl: String
    let apiKey: String

    init(configuration: Configuration, section: Section = .home) {
        self.baseUrl = configuration.baseUrl
        self.apiKey = configuration.apiKey
        self.section = section
    }
}
