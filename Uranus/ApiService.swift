//
//  ApiService.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/22.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import Combine
import PKHUD

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

enum Request {
    case getPersonalInformation
    case updatePersonalInformation(information: PersonalInformation)
    case getBoardingPassToken(flightID: Int64)
    case getFlightList
    case getFlightDetail(flightID: Int64)
    case checkin(flightID: Int64, numberOfLuggages: Int, accompanyingPersons: [String])
    case updatePassengerStatus(passengerID: String, status: Int)
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Task {
    case requestPlain
    case requestData(data: Data?)
    case requestParameters(parameters: [String: Any])
}

extension Request: TargetType {
    var baseURL: URL {
        return URL(string: "http://10.0.0.116:5000")!
    }

    var path: String {
        switch self {
        case .getPersonalInformation, .updatePersonalInformation:
            return "/information"
        case .getBoardingPassToken, .updatePassengerStatus:
            return "/boardingPass"
        case .getFlightList:
            return "/flights"
        case .getFlightDetail(let flightID):
            return "/flights/\(flightID)"
        case .checkin:
            return "/checkin"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPersonalInformation, .getBoardingPassToken, .getFlightList, .getFlightDetail:
            return .GET
        case .checkin:
            return .POST
        case .updatePersonalInformation, .updatePassengerStatus:
            return .PUT
        }
    }

    var task: Task {
        switch self {
        case .updatePersonalInformation(let information):
            let jsonObject: [String: Any] = [
                "name": information.legalName,
                "first_name": information.firstName,
                "last_name": information.lastName,
                "email": information.email,
                "id_number": information.IDNumber
            ]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                return .requestData(data: jsonData)
            } catch {
                DispatchQueue.main.async {
                    HUD.flash(.labeledError(title: "错误", subtitle: "parameters parsed error"), delay: 1.0)
                }
                return .requestPlain
            }
        case .getBoardingPassToken(let flightID):
            return .requestParameters(parameters: ["flight_id": flightID])
        case .checkin(let flightID, let numberOfLuggages, let accompanyingPersons):
            let jsonObject: [String: Any] = [
                "flight_id": flightID,
                "number_of_luggages": numberOfLuggages,
                "accompanying_persons": accompanyingPersons
            ]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                return .requestData(data: jsonData)
            } catch {
                DispatchQueue.main.async {
                    HUD.flash(.labeledError(title: "错误", subtitle: "parameters parsed error"), delay: 1.0)
                }
                return .requestPlain
            }
        case .updatePassengerStatus(let passengerID, let status):
            let jsonObject: [String: Any] = [
                "passenger_id": passengerID,
                "passenger_status": status
            ]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                return .requestData(data: jsonData)
            } catch {
                DispatchQueue.main.async {
                    HUD.flash(.labeledError(title: "错误", subtitle: "parameters parsed error"), delay: 1.0)
                }
                return .requestPlain
            }
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getPersonalInformation, .getBoardingPassToken, .getFlightList, .getFlightDetail:
            return nil
        case .updatePersonalInformation, .checkin, .updatePassengerStatus:
            return ["Content-Type": "application/json"]
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
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            let dateFormatter = ISO8601DateFormatter()
            return dateFormatter.date(from: string) ?? Date()
        }

        let pathURL = URL(string: target.path, relativeTo: target.baseURL)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!

        switch target.task {
        case .requestParameters(let parameters):
            urlComponents.queryItems = parameters.map { key, value in
                guard let intValue = value as? Int64 else { return URLQueryItem(name: key, value: "") }
                return URLQueryItem(name: key, value: String(intValue))
            }
        default:
            break
        }

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = target.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cmFudXMiLCJleHAiOjE1Nzk3MTE5MjIsImlhdCI6MTU3NzExOTkyMiwicm9sZSI6InBhc3NlbmdlciIsImlkZW50aWZpZXIiOjE1NzY4OTYzODI1NjF9.lcq00eAI-K17hx-rtyh-9DZac7CefJaszj0Tmw68hPk", forHTTPHeaderField: "Authorization")
        if target.headers != nil {
            target.headers?.forEach { header in
                request.addValue(header.1, forHTTPHeaderField: header.0)
            }
        }

        switch target.task {
        case .requestData(let data):
            request.httpBody = data
        default:
            break
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
