//
//  EKEventStore+Event.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import EventKit
import PKHUD

protocol Event {
    func addEvent(flight: Flight, alertTime: Date?)
}

extension EKEventStore: Event {

    func addEvent(flight: Flight, alertTime: Date?) {
        if let calendar = self.defaultCalendarForNewEvents {
            let event = EKEvent(eventStore: self)
            event.calendar = calendar
            event.title = "\(flight.flightNumber) / \(flight.fromCityAirportCode) To \(flight.toCityAirportCode)"
            event.startDate = flight.departureTime
            event.endDate = flight.arrivalTime

            if alertTime != nil {
                event.addAlarm(EKAlarm(absoluteDate: alertTime!))
            } else {
                event.addAlarm(EKAlarm(relativeOffset: TimeInterval(-2 * 60 * 60)))
            }

            do {
                try self.save(event, span: .thisEvent, commit: true)
            } catch {

            }
        }
    }

}
