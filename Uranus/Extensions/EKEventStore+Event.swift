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
            event.title = "\(flight.flightNumber) / \(flight.originAirport.positionCode) To \(flight.destinationAirport.positionCode)"
            event.startDate = flight.departureTime
            event.endDate = flight.arrivalTime
            event.notes =
            """
                \(flight.flightNumber)
            """

            if alertTime != nil {
                event.addAlarm(EKAlarm(absoluteDate: alertTime!))
            } else {
                event.addAlarm(EKAlarm(relativeOffset: TimeInterval(-2 * 60 * 60)))
            }

            do {
                try self.save(event, span: .thisEvent, commit: true)
            } catch {
                DispatchQueue.main.async {
                    HUD.flash(.labeledError(title: "错误", subtitle: "添加失败"), delay: 1.0)
                }
            }
            DispatchQueue.main.async {
                HUD.flash(.success, delay: 1.0)
            }
        }
    }

}
