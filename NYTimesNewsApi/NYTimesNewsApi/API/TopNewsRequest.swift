//
//  TopNewsRequest.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

struct TopNewsRequest: DataRequest {
    var url: String = "https://api.nytimes.com/svc/topstories/v2/home.json"

    typealias Response = TopNewsResponse

}
