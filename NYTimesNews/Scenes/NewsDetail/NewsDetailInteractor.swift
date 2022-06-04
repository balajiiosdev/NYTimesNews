//
//  NewsDetailInteractor.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/4/22.
//

import UIKit
import NYTimesNewsApi

protocol NewsDetailBusinessLogic {
    func fetchNewsDetails(request: NewsDetail.Request)
}

protocol NewsDetailDataStore {
    var article: Article? { get set }
}

class NewsDetailInteractor: NewsDetailBusinessLogic, NewsDetailDataStore {
    var presenter: NewsDetailPresentationLogic?
    var article: Article?

    // MARK: News details

    func fetchNewsDetails(request: NewsDetail.Request) {
        guard let articleUnwrapped = article else { return }
        let response = NewsDetail.Response(article: articleUnwrapped)
        presenter?.presentNewsDetails(response: response)
    }
}
