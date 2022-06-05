//
//  NewsListPresenter.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit
import NYTimesNewsApi

protocol NewsListPresentationLogic {
    func presentTopNews(response: NewsList.TopNews.Response)
    func presentError(error: Error)
}

class NewsListPresenter: NewsListPresentationLogic {
    weak var viewController: NewsListDisplayLogic?

    // MARK: Top News
    func presentTopNews(response: NewsList.TopNews.Response) {
        let topNews = response.topNews
        let articles = topNews.results.compactMap { article -> ArticleModel? in
            return createArticleModel(article: article)
        }

        let viewModel = NewsList.TopNews.ViewModel(articles: articles,
                                                   copyright: topNews.copyright,
                                                   lastUpdatedDate: topNews.lastUpdated)
        viewController?.displayTopNews(viewModel: viewModel)
    }

    func presentError(error: Error) {
        if let httpError = error as? HttpError {
            handleHttpError(httpError)
        } else {
            let nsError = error as NSError
            if nsError.code == NSURLErrorNotConnectedToInternet {
                showNoInternetError()
            } else {
                showDefaultError()
            }
        }
    }

    private func createArticleModel(article: Article) -> ArticleModel? {
        let thumbnailMediaItem = article.multimediaItems.first {
            $0.format == .largeThumbnail
        }
        guard let urlString = thumbnailMediaItem?.url,
              let url = URL(string: urlString) else {
                  return nil
              }
        let thumbnail = MediaItem(url: url)
        let model = ArticleModel(title: article.title,
                                 author: article.byline,
                                 thumbnail: thumbnail)
        return model
    }

    private func handleHttpError(_ error: HttpError) {
        if error == .serviceUnavailable || error == .internalServerError {
            let message = NSLocalizedString("server_unavailable_message", comment: "")
            let title = NSLocalizedString("error_occured", comment: "")
            viewController?.displayErrorAlert(title: title, message: message)
        } else {
            showDefaultError()
        }
    }

    private func showDefaultError() {
        let title = NSLocalizedString("error_occured", comment: "")
        let message = NSLocalizedString("something_went_wrong", comment: "")
        viewController?.displayErrorAlert(title: title, message: message)
    }

    private func showNoInternetError() {
        let title = NSLocalizedString("no_internet_connection_title", comment: "")
        let message = NSLocalizedString("no_internet_connection_message", comment: "")
        viewController?.displayErrorAlert(title: title, message: message)
    }
}
