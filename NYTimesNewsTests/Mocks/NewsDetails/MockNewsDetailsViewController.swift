//
//  MockNewsDetailsViewController.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
@testable import NYTimesNews
import UIKit

class MockNewsDetailsViewController: UIViewController, NewsDetailDisplayLogic {
    var displayNewsDetailsCalledCount = 0
    var viewModel: NewsDetail.ViewModel?
    var presentViewControllerCalledCount = 0
    var viewControllerToPresent: UIViewController?

    func displayNewsDetails(viewModel: NewsDetail.ViewModel) {
        displayNewsDetailsCalledCount += 1
        self.viewModel = viewModel
    }

    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        presentViewControllerCalledCount += 1
        self.viewControllerToPresent = viewControllerToPresent
    }
}
