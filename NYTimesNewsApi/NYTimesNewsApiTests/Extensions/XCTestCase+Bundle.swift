//
//  XCTestCase+Bundle.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import Foundation
import XCTest

extension XCTestCase {
    func url(for fileName: String) -> URL? {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: fileName,
                                   withExtension: nil) else {
            return nil
        }
        return url
    }
}
