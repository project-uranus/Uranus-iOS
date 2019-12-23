//
//  Flight.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct Flight: Codable {
    // swiftlint:disable identifier_name
    let id: Int64
    let airline: String
    let flightNumber: String
    let aircraft: String
    let dateOfFlight: String
    let departureTime: Date
    let arrivalTime: Date
    let originAirport: City
    let destinationAirport: City
    let status: FlightStatus
}

extension Flight {
    struct City: Codable {
        let position: String
        let positionCode: String
    }
}
