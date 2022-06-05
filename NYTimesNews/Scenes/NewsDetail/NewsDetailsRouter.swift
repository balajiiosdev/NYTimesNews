//
//  NewsDetailsRouter.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/4/22.
//

import UIKit
import SafariServices

@objc protocol NewsDetailsRoutingLogic {
    func routeToWebView()
}

protocol NewsDetailDataPassing {
    var dataStore: NewsDetailDataStore? { get }
}

class NewsDetailsRouter: NSObject, NewsDetailsRoutingLogic, NewsDetailDataPassing {
    weak var viewController: UIViewController?
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
