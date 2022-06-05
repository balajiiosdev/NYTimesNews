//
//  MockNewsDetailsRouter.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
@testable import NYTimesNews

class MockNewsDetailsRouter: NSObject, NewsDetailsRoutingLogic, NewsDetailDataPassing {
    var dataStore: NewsDetailDataStore?
    var routeToWebViewCalledCount = 0

    func routeToWebView() {
        routeToWebViewCalledCount += 1
    }
}
