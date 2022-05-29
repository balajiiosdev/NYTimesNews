//
//  NetworkServiceError.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/30/22.
//

import Foundation

enum NetworkServiceError: Error {
    case noDataFound
    case malformedUrl
    case unknown
}

enum HttpError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestURITooLarge = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case tooManyRequests = 429
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
}
