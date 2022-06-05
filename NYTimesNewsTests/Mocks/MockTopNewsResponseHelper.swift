//
//  MockTopNewsResponseHelper.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import Foundation
import NYTimesNewsApi

class MockTopNewsResponseHelper {
    static func topNewsResponse() -> TopNewsResponse? {
        guard let fileUrl = url(for: MockDataFileNames.topNewsValidResponse) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let response = try decoder.decode(TopNewsResponse.self, from: data)
            return response
        } catch {
            return nil
        }
    }

    static func url(for fileName: String) -> URL? {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: fileName,
                                   withExtension: nil) else {
            return nil
        }
        return url
    }
}
