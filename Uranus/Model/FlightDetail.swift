//
//  FlightDetail.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/23.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct FlightDetail: Codable {
    let uuid: UUID = .init()
    let flight: FlightDetail.Flight
    let spec: FlightDetail.Specification
}

extension FlightDetail {
    struct Flight: Codable {
        let airline: String
        let flightNumber: String
        let aircraft: String
        let dateOfFlight: String
        let departureTime: Date
        let arrivalTime: Date
        let originAirport: Airport
        let destinationAirport: Airport
        let boardingTime: Date
        let boardingGate: String
        let status: FlightStatus
    }

    struct Specification: Codable {
        let compartmentCode: String
        let seatNumber: String
        let luggages: [Luggage]
    }
}

extension FlightDetail.Specification {
    struct Luggage: Codable {
        let luggageID: Int64
        let weight: Double
        let status: String

        enum CodingKeys: String, CodingKey {
            case luggageID = "luggageId"
            case weight
            case status
        }
    }
}
