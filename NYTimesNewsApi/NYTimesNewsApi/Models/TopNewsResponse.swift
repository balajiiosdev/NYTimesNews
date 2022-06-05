//
//  TopNewsResponse.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

/// TopNewsResponse is used to store the top news server response
public struct TopNewsResponse: Codable {
    public let status: String
    public let copyright: String
    public let section: String
    public let lastUpdated: String
    public let numOfResults: Int
    public let results: [Article]

    public init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        status = try map.decode(String.self, forKey: .status)
        copyright = try map.decode(String.self, forKey: .copyright)
        section = try map.decode(String.self, forKey: .section)
        lastUpdated = try map.decode(String.self, forKey: .lastUpdated)
        numOfResults = try map.decode(Int.self, forKey: .numOfResults)
        results = try map.decode([Article].self, forKey: .results)
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
