//
//  NewsDetailPresenter.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/4/22.
//

import UIKit

protocol NewsDetailPresentationLogic {
    func presentNewsDetails(response: NewsDetail.Response)
}

class NewsDetailPresenter: NewsDetailPresentationLogic {
    weak var viewController: NewsDetailDisplayLogic?

    func presentNewsDetails(response: NewsDetail.Response) {
        let article = response.article
        let jumboMediaItem = article.multimediaItems.first {
            $0.format == .superJumbo
        }
        guard let urlString = jumboMediaItem?.url,
              let url = URL(string: urlString) else {
                  return
              }
        let mediaItem = MediaItem(url: url)
        let articleDetails = ArticleDetail(title: article.title,
                                           author: article.byline,
                                           description: article.abstract,
                                           jumboImage: mediaItem)
        let viewModel = NewsDetail.ViewModel(articleDetails: articleDetails)
        viewController?.displayNewsDetails(viewModel: viewModel)
    }
}
