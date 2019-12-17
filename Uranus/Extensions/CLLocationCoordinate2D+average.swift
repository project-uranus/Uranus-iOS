//
//  CLLocationCoordinate2D+average.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/5.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import MapKit

public extension CLLocationCoordinate2D {
    static func average(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return .init(latitude: (origin.latitude + destination.latitude) * 0.5, longitude: (origin.longitude + destination.longitude) * 0.5)
    }
}
