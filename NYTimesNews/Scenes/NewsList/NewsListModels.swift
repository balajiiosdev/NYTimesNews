//
//  NewsListModels.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit
import NYTimesNewsApi

enum NewsList {
    // MARK: Use cases

    enum TopNews {
        // swiftlint:disable nesting
        struct Request {
            let section: Section
        }
        struct Response {
            let topNews: TopNewsResponse
        }
        struct ViewModel {
            let articles: [ArticleModel]
            let copyright: String
            let lastUpdatedDate: String
        }
        // swiftlint:enable nesting
    }
}

struct ArticleModel {
    let title: String
    let author: String
    let mediaItem: MediaItem
}

struct MediaItem {
    let url: URL
}
