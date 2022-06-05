//
//  Reachable.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
import Reachability

protocol Reachable {
    var connection: Reachability.Connection { get }
    var whenReachable: Reachability.NetworkReachable? { get set }
    var whenUnreachable: Reachability.NetworkUnreachable? { get set }

    func startNotifier() throws
    func stopNotifier()
}

extension Reachability: Reachable {
}
