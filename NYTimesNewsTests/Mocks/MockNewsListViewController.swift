//
//  MockNewsListViewController.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import Foundation
import UIKit
@testable import NYTimesNews
import XCTest

class MockNewsListViewController: UIViewController, NewsListDisplayLogic {
    var displayTopNewsCalledCount = 0
    var displayErrorAlertCalledCount = 0
    var displayToastCalledCount = 0
    var viewModel: NewsList.TopNews.ViewModel?
    var alertMessage: String?
    var alertTitle: String?
    var toastMessage: String?
    var expectation: XCTestExpectation?

    func displayTopNews(viewModel: NewsList.TopNews.ViewModel) {
        displayTopNewsCalledCount += 1
        self.viewModel = viewModel
        expectation?.fulfill()
    }

    func displayErrorAlert(title: String?, message: String?) {
        displayErrorAlertCalledCount += 1
        alertTitle = title
        alertMessage = message
        expectation?.fulfill()
    }
}
