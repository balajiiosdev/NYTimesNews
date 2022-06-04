//
//  NewsDetailRouter.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/4/22.
//

import UIKit
import SafariServices

@objc protocol NewsDetailRoutingLogic {
    func routeToWebView()
}

protocol NewsDetailDataPassing {
    var dataStore: NewsDetailDataStore? { get }
}

class NewsDetailRouter: NSObject, NewsDetailRoutingLogic, NewsDetailDataPassing {
    weak var viewController: NewsDetailViewController?
    var dataStore: NewsDetailDataStore?

    func routeToWebView() {
        guard let urlString = dataStore?.article?.url,
              let url  = URL(string: urlString) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariViewController = SFSafariViewController(url: url, configuration: config)
        viewController?.present(safariViewController, animated: true)
    }
}
