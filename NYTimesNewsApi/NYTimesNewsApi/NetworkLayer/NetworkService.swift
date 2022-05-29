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

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    private func buildUrl<Request: DataRequest>(request: Request) throws -> URL {
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(
                domain: "HttpError",
                code: 404,
                userInfo: nil
            )
            throw error
        }

        var queryItems: [URLQueryItem] = []
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else {
            let error = NSError(
                domain: "HttpError",
                code: 404,
                userInfo: nil
            )
            throw error
        }
        return url
    }

    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.Response, Error>) -> Void) {
        var url: URL
        do {
            url = try buildUrl(request: request)
        } catch {
            completion(.failure(error))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                let internalServerError = 500
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? internalServerError
                let httpError = NSError(domain: "HttpError", code: statusCode, userInfo: nil)
                return completion(.failure(httpError))
            }
            guard let data = data else {
                return completion(.failure(NSError()))
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
