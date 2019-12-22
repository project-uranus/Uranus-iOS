//
//  Airport.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/5.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import MapKit

struct Airport: Codable {
    let IATA: String
    let name: String
    let position: String
    let latitude: Double
    let longitude: Double
}

class AirportAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?

    init(airport: Airport) {
        self.coordinate = .init(latitude: airport.latitude, longitude: airport.longitude)
        self.title = airport.position
        self.subtitle = airport.name
    }
}
