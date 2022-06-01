//
//  Configuration.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/30/22.
//

import Foundation

protocol Configurable {
    var baseUrl: String { get }
    var apiKey: String { get }
}

public struct Configuration: Configurable {
    public let baseUrl: String
    public let apiKey: String

    public init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
}
