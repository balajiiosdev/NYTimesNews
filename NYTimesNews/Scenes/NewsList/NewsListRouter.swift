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
    }
}
