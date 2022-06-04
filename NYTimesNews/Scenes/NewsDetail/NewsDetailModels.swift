//
//  NewsDetailModels.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/4/22.
//

import UIKit
import NYTimesNewsApi

enum NewsDetail {
  // MARK: Use cases
    struct Request {
    }
    struct Response {
        let article: Article
    }
    struct ViewModel {
        let articleDetails: ArticleDetail
    }
}

struct ArticleDetail {
    let title: String
    let author: String
    let description: String
    let jumboImage: MediaItem?
}
