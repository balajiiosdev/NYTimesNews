//
//  TopNewsResponse.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

public struct TopNewsResponse: Codable {
    let status: String
    let copyright: String
    let section: String
    let lastUpdated: String
    let numOfResults: Int
    let results: [Article]

    public init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        status = try map.decode(String.self, forKey: .status)
        copyright = try map.decode(String.self, forKey: .copyright)
        section = try map.decode(String.self, forKey: .section)
        lastUpdated = try map.decode(String.self, forKey: .lastUpdated)
        numOfResults = try map.decode(Int.self, forKey: .numOfResults)
        results = try map.decodeIfPresent([Article].self, forKey: .results) ?? []
    }

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case section
        case results
        case lastUpdated = "last_updated"
        case numOfResults = "num_results"
    }
}
