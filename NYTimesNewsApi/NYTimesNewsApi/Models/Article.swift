//
//  Article.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

public struct Article: Codable {
    public let section: String
    public let subsection: String
    public let title: String
    public let abstract: String
    public let url: String
    public let uri: String
    public let byline: String
    public let itemType: String
    public let updatedDate: String
    public let createdDate: String
    public let publishedDate: String
    public let materialTypeFacet: String
    public let kicker: String
    public let shortUrl: String
    public let desFacet: [String]
    public let orgFacet: [String]
    public let perFacet: [String]
    public let geoFacet: [String]
    public let multimediaItems: [MultiMediaItem]

    public init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        section = try map.decode(String.self, forKey: CodingKeys.section)
        subsection =  try map.decode(String.self, forKey: CodingKeys.subsection)
        title = try map.decode(String.self, forKey: CodingKeys.title)
        abstract = try map.decode(String.self, forKey: CodingKeys.abstract)
        url = try map.decode(String.self, forKey: CodingKeys.url)
        uri = try map.decode(String.self, forKey: CodingKeys.uri)
        byline = try map.decode(String.self, forKey: CodingKeys.byline)
        itemType = try map.decode(String.self, forKey: CodingKeys.itemType)
        updatedDate = try map.decode(String.self, forKey: CodingKeys.updatedDate)
        createdDate = try map.decode(String.self, forKey: CodingKeys.createdDate)
        publishedDate = try map.decode(String.self, forKey: CodingKeys.publishedDate)
        materialTypeFacet = try map.decode(String.self,
                                           forKey: CodingKeys.materialTypeFacet)
        kicker = try map.decode(String.self, forKey: CodingKeys.kicker)
        shortUrl = try map.decode(String.self, forKey: CodingKeys.shortUrl)
        desFacet = try map.decode([String].self, forKey: CodingKeys.desFacet)
        orgFacet = try map.decode([String].self, forKey: CodingKeys.orgFacet)
        perFacet = try map.decode([String].self, forKey: CodingKeys.perFacet)
        geoFacet = try map.decode([String].self, forKey: CodingKeys.geoFacet)
        multimediaItems = try map.decode([MultiMediaItem].self, forKey: CodingKeys.multimediaItems)
    }

    enum CodingKeys: String, CodingKey {
        case url
        case uri
        case title
        case byline
        case kicker
        case section
        case abstract
        case subsection
        case itemType = "item_type"
        case shortUrl = "short_url"
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case updatedDate = "updated_date"
        case createdDate = "created_date"
        case publishedDate = "published_date"
        case multimediaItems = "multimedia"
        case materialTypeFacet = "material_type_facet"
    }
}
