//
//  MockNewsListRouter.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
@testable import NYTimesNews

class MockNewsListRouter: NSObject, NewsListRoutingLogic, NewsListDataPassing {
    var dataStore: NewsListDataStore?
    var routeToNewsDetailViewCalled = 0
    var index: Int = -1

    func routeToNewsDetailView(at index: Int) {
        self.index = index
        routeToNewsDetailViewCalled += 1
    }
}
