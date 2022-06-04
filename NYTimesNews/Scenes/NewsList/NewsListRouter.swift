//
//  NewsListRouter.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit

@objc protocol NewsListRoutingLogic {
    func routeToNewsDetailView(at index: Int)
}

protocol NewsListDataPassing {
    var dataStore: NewsListDataStore? { get }
}

class NewsListRouter: NSObject, NewsListRoutingLogic, NewsListDataPassing {
    weak var viewController: NewsListViewController?
    var dataStore: NewsListDataStore?

    // MARK: Routing

    func routeToNewsDetailView(at index: Int) {
        let article = dataStore?.articles[index]
        let storyboard = viewController?.storyboard
        let identifier = "NewsDetailViewController"
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier:
                                                                        identifier) as? NewsDetailViewController,
              let router = detailsVC.router else {
            return
        }
        var destinationDS = router.dataStore
        destinationDS?.article = article
        viewController?.show(detailsVC, sender: nil)
    }
}
