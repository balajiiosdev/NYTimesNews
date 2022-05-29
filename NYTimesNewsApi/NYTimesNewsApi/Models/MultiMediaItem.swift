//
//  MultiMediaItem.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

public struct MultiMediaItem: Codable {
    let url: String
    let format: String
    let height: Int
    let width: Int
    let type: String
    let subtype: String
    let caption: String
    let copyright: String

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
        format = try map.decode(String.self, forKey: .format)
        height = try map.decode(Int.self, forKey: .height)
        width = try map.decode(Int.self, forKey: .width)
        type = try map.decode(String.self, forKey: .type)
        subtype = try map.decode(String.self, forKey: .subtype)
        caption = try map.decode(String.self, forKey: .caption)
        copyright = try map.decode(String.self, forKey: .copyright)
    }
}
