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
    func addEvent(flightDetail: FlightDetail, alertTime: Date?)
}

extension EKEventStore: Event {

    func addEvent(flightDetail: FlightDetail, alertTime: Date?) {
        if let calendar = self.defaultCalendarForNewEvents {
            let event = EKEvent(eventStore: self)
            event.calendar = calendar
            event.title = "\(flightDetail.flight.flightNumber) / \(flightDetail.flight.originAirport.IATA) To \(flightDetail.flight.destinationAirport.IATA)"
            event.startDate = flightDetail.flight.departureTime
            event.endDate = flightDetail.flight.arrivalTime
            event.notes =
            """
            \(flightDetail.flight.flightNumber)
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
