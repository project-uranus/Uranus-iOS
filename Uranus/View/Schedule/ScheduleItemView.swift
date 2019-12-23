//
//  ScheduleItemView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/3.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct ScheduleItemView: View {
    @State var flight: Flight

    var body: some View {
        HStack {
            ZStack {
                Panel()
                VStack {
                    HStack {
                        StatusChip(status: flight.status)
                        Spacer()
                        Text(flight.dateOfFlight)
                            .font(.caption)
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Text(flight.originAirport.position)
                                .bold()
                            Text(flight.originAirport.positionCode)
                                .foregroundColor(.gray)
                            Text(flight.departureTime.toString(with: .HHmm))
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "airplane")
                        Spacer()
                        VStack {
                            Text(flight.destinationAirport.position)
                                .bold()
                            Text(flight.destinationAirport.positionCode)
                                .foregroundColor(.gray)
                            Text(flight.arrivalTime.toString(with: .HHmm))
                                .font(.caption)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("\(flight.airline) · \(flight.flightNumber) · \(flight.aircraft)")
                            .font(.footnote)
                        Spacer()
                    }
                }
                .padding(16)
            }
            NavigationLink(destination: ScheduleDetailView(flightID: flight.id)) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
        }
    }
}

struct ScheduleItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ScheduleItemView(flight: Flight(
                id: 1576998137,
                airline: "中国东方航空",
                flightNumber: "MU291",
                aircraft: "Airbus A320",
                dateOfFlight: "2019-12-19",
                departureTime: .init(timeIntervalSince1970: 1576746900),
                arrivalTime: .init(timeIntervalSince1970: 1576759200),
                originAirport: Flight.City(position: "上海", positionCode: "SHA"),
                destinationAirport: Flight.City(position: "名古屋", positionCode: "NGO"),
                status: .scheduled
            ))
        }
    }
}
