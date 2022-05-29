//
//  TopNewsRequest.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

struct TopNewsRequest: DataRequest {
    var url: String = "https://api.nytimes.com/svc/topstories/v2/home.json"
    var queryItems: [String: String] = ["apiKey": "12345"]
    typealias Response = TopNewsResponse
    let section: Section

    init(section: Section = .home) {
        self.section = section
    }

}
