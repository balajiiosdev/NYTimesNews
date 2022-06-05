//
//  MockReachability.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
import Reachability
@testable import NYTimesNews

class MockReachability: Reachable {
    var connection: Reachability.Connection = .wifi
    var whenReachable: Reachability.NetworkReachable?
    var whenUnreachable: Reachability.NetworkUnreachable?
    var startNotifierCalledCount = 0
    var stopNotifierCalledCount = 0

    func startNotifier() throws {
        startNotifierCalledCount += 1
    }

    func stopNotifier() {
        stopNotifierCalledCount += 1
    }
}
