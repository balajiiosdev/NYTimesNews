//
//  MultiMediaItem.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

public enum MediaItemFormat: Codable {
    case superJumbo
    case threeByTwoSmallAt2X
    case largeThumbnail
    case unknown(value: String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "Super Jumbo": self = .superJumbo
        case "threeByTwoSmallAt2X" : self = .threeByTwoSmallAt2X
        case "Large Thumbnail": self = .largeThumbnail
        default:
            self = .unknown(value: status ?? "unknown")
        }
    }
}

extension MediaItemFormat: Comparable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.superJumbo, .superJumbo): return true
        case (.threeByTwoSmallAt2X, .threeByTwoSmallAt2X): return true
        case (.largeThumbnail, .largeThumbnail): return true
        case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
        }
    }
}

public struct MultiMediaItem: Codable {
    public let url: String
    public let format: MediaItemFormat
    public let height: Int
    public let width: Int
    public let type: String
    public let subtype: String
    public let caption: String
    public let copyright: String

    enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
        case type
        case subtype
        case caption
        case copyright
    }

    public init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        url = try map.decode(String.self, forKey: .url)
        format = try map.decode(MediaItemFormat.self, forKey: .format)
        height = try map.decode(Int.self, forKey: .height)
        width = try map.decode(Int.self, forKey: .width)
        type = try map.decode(String.self, forKey: .type)
        subtype = try map.decode(String.self, forKey: .subtype)
        caption = try map.decode(String.self, forKey: .caption)
        copyright = try map.decode(String.self, forKey: .copyright)
    }
}
