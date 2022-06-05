//
//  MockTableView.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
import UIKit
import XCTest

class MockTableView: UITableView {
    var reloadDataCalledCount = 0
    var expectation: XCTestExpectation?

    override func reloadData() {
        reloadDataCalledCount += 1
        expectation?.fulfill()
    }
}
