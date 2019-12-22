//
//  ApiService.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/22.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import Combine

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
}

enum Request {
    case getBoardingPassToken
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

extension Request: TargetType {
    var baseURL: URL {
        return URL(string: "https://private-b5a4f-uranus.apiary-mock.com/")!
    }

    var path: String {
        switch self {
        case .getBoardingPassToken:
            return "/boardingPass"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getBoardingPassToken:
            return .GET
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}

protocol ApiServiceType: AnyObject {
    associatedtype Target: TargetType
}

internal let apiService = ApiService<Request>()

final class ApiService<Target: TargetType>: ApiServiceType {

    func request<T: Codable>(_ target: Target, with type: T.Type) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let pathURL = URL(string: target.path, relativeTo: target.baseURL)!
        logger.debug(pathURL.absoluteURL)
        let urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        //        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = target.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if target.headers != nil {
            target.headers?.forEach { header in
                request.addValue(header.1, forHTTPHeaderField: header.0)
            }
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
