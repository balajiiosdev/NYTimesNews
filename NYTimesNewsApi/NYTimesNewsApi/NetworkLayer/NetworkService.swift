//
//  NetworkService.swift
//  NYTimesNewsApi
//
//  Created by Balaji V on 5/29/22.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.Response, Error>) -> Void)
}

/**
 `NetworkService` responsible to make the network requests
 */
final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    private func buildUrl<Request: DataRequest>(request: Request) -> URL? {
        guard var urlComponent = URLComponents(string: request.url) else {
            return nil
        }
        var queryItems: [URLQueryItem] = []
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }

    /// Makes the network request with DataRequest
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.Response, Error>) -> Void) {
        guard let url = buildUrl(request: request) else {
            return completion(.failure(NetworkServiceError.malformedUrl))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkServiceError.unknown))
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                let httpError = HttpError(rawValue: httpResponse.statusCode) ?? HttpError.internalServerError
                return completion(.failure(httpError))
            }
            guard let data = data else {
                return completion(.failure(NetworkServiceError.noDataFound))
            }
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
