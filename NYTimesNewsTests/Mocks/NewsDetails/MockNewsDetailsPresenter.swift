//
//  MockNewsDetailsPresenter.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
@testable import NYTimesNews

class MockNewsDetailsPresenter: NewsDetailPresentationLogic {
    var presentNewsDetailsCalledCount = 0
    var response: NewsDetail.Response?

    func presentNewsDetails(response: NewsDetail.Response) {
        presentNewsDetailsCalledCount += 1
        self.response = response
    }
}
