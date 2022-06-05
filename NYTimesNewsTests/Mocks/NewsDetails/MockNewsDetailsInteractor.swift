//
//  MockNewsDetailsInteractor.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
@testable import NYTimesNews
import NYTimesNewsApi

class MockNewsDetailsInteractor: NewsDetailBusinessLogic, NewsDetailDataStore {
    var article: Article?
    var fetchNewsDetailsCalledCount = 0

    func fetchNewsDetails(request: NewsDetail.Request) {
        fetchNewsDetailsCalledCount += 1
    }
}
