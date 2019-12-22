//
//  Flight.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct Flight: Codable {
    let uuid: UUID = .init()
    let airline: String
    let flightNumber: String
    let aircraft: String
    let dateOfFlight: Date
    let departureTime: Date
    let arrivalTime: Date
    let originAirport: City
    let destinationAirport: City
    let status: FlightStatus
}

struct FlightDetail: Codable {
//    struct Flight: Codable {
//        <#fields#>
//    }
}
