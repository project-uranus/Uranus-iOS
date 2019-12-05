//
//  Airport.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/5.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import MapKit

struct Airport {
    let IATA: String
    let name: String
    let position: String
    let coordinate: CLLocationCoordinate2D
}

class AirportAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?

    init(airport: Airport) {
        self.coordinate = airport.coordinate
        self.title = airport.position
        self.subtitle = airport.name
    }
}
