//
//  ScheduleDetailView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/4.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import EventKit
import PKHUD

func authenticate(onSuccess: @escaping () -> Void) {
    let context = LAContext()
    var error: NSError?
    var localizedReasonString: String?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .touchID:
                localizedReasonString = "使用 Touch ID 验证"
            case .faceID:
                localizedReasonString = "使用 Face ID 验证"
            case .none:
                break
            @unknown default:
                break
            }
        } else {
            localizedReasonString = "使用 Touch ID 验证"
        }

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReasonString ?? "") { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                    onSuccess()
                } else {
                    HUD.flash(.labeledError(title: "错误", subtitle: authenticationError?.localizedDescription), delay: 1.0)
                }
            }
        }
    } else {
        #if targetEnvironment(simulator)
        onSuccess()
        #else
        DispatchQueue.main.async {
            HUD.flash(.labeledError(title: "错误", subtitle: "No biometrics."), delay: 1.0)
        }
        #endif
    }
}

struct ScheduleDetailView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject private var store: AppStore

    @State private var isBoardingPassViewPresented: Bool = false
    @State private var isCheckInViewPresented: Bool = false
    @State private var flightDetail: FlightDetail = .init(
        flight: .init(
            airline: "",
            flightNumber: "",
            aircraft: "",
            dateOfFlight: "",
            departureTime: Date(),
            arrivalTime: Date(),
            originAirport: Airport(IATA: "", name: "", position: "", latitude: 0, longitude: 0),
            destinationAirport: Airport(IATA: "", name: "", position: "", latitude: 0, longitude: 0),
            boardingTime: Date(),
            boardingGate: "",
            status: .noTakeoffInfo
        ),
        spec: .init(
            compartmentCode: "",
            seatNumber: "",
            luggages: []
        )
    )

    @State var flightID: Int64

    var disposeBag = DisposeBag()

    var buttonGroup: some View {
        HStack {
            Button(action: {
                let eventStore = EKEventStore()
                eventStore.requestAccess(to: .event) { granted, error in
                    if granted {
                        eventStore.addEvent(
                            flightDetail: self.flightDetail,
                            alertTime: nil
                        )
                    } else {
                        DispatchQueue.main.async {
                            HUD.flash(.labeledError(title: "错误", subtitle: error?.localizedDescription), delay: 1.0)
                        }
                    }
                }
            }, label: {
                HStack {
                    Image(systemName: "calendar.badge.plus")
                    Text("添加到日历")
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            })
                .buttonStyle(BorderlessButtonStyle())
                .background(Color.red.opacity(colorScheme == .dark ? 0.25 : 1))
                .cornerRadius(8)
            Spacer()
                .frame(width: 10)
            Button(action: {
                self.isCheckInViewPresented = true
            }, label: {
                HStack {
                    Image(systemName: "person.crop.circle.badge.checkmark")
                    Text(store.state.activeCounter == nil ? "值机" : "值机柜台 \(store.state.activeCounter!)")
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            })
                .buttonStyle(BorderlessButtonStyle())
                .background(Color.theme.opacity(colorScheme == .dark ? 0.25 : 1))
                .cornerRadius(8)
                .sheet(isPresented: $isCheckInViewPresented) {
                    CheckInView(flightID: self.flightID).environmentObject(self.store)
            }
            .disabled(store.state.activeCounter != nil)
        }
    }

    var body: some View {
        List {
            buttonGroup
            ZStack {
                Panel()
                VStack {
                    HStack {
                        VStack(alignment: .trailing) {
                            Spacer()
                            Text(flightDetail.flight.departureTime.toString(with: .HHmm))
                                .font(.caption)
                            Spacer()
                            Text(flightDetail.flight.arrivalTime.toString(with: .HHmm))
                                .font(.caption)
                            Spacer()
                        }
                        TimeLine(radius: 3)
                            .frame(width: 6)
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(flightDetail.flight.originAirport.name)
                            Text(flightDetail.flight.originAirport.IATA)
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(flightDetail.flight.destinationAirport.name)
                            Text(flightDetail.flight.destinationAirport.IATA)
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding()
            }
            HStack {
                ZStack {
                    Panel()
                    VStack {
                        Text("航空公司")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flightDetail.flight.airline)
                            .font(.subheadline)
                            .bold()
                    }
                    .padding(4)
                }
                Spacer()
                    .frame(width: 10)
                ZStack {
                    Panel()
                    VStack {
                        Text("状态")
                            .font(.caption)
                            .foregroundColor(.gray)
                        StatusChip(status: flightDetail.flight.status)
                    }
                    .padding()
                }
            }
            HStack {
                ZStack {
                    Panel()
                    VStack {
                        Text("日期")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flightDetail.flight.dateOfFlight)
                            .font(.subheadline)
                            .bold()
                    }
                    .padding()
                }
                Spacer()
                    .frame(width: 10)
                ZStack {
                    Panel()
                    VStack {
                        Text("登机时间")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flightDetail.flight.boardingTime.toString(with: .HHmm))
                            .font(.title)
                    }
                    .padding()
                }
            }
            HStack {
                ZStack {
                    Panel()
                    VStack {
                        Text("舱位")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flightDetail.spec.compartmentCode)
                            .font(.title)
                    }
                    .padding()
                }
                Spacer()
                    .frame(width: 10)
                ZStack {
                    Panel()
                    VStack {
                        Text("座位号")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flightDetail.spec.seatNumber)
                            .font(.title)
                    }
                    .padding()
                }
                Spacer()
                    .frame(width: 10)
                ZStack {
                    Panel()
                    VStack {
                        Text("登机口")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flightDetail.flight.boardingGate)
                            .font(.title)
                    }
                    .padding()
                }
            }
            MapView(
                originAirport: Airport(IATA: "PVG", name: "上海浦东国际机场", position: "上海", latitude: 31.143333, longitude: 121.805278),
                destinationAirport: Airport(IATA: "NGO", name: "中部国际机场", position: "名古屋", latitude: 34.858333, longitude: 136.805278)
            )
                .frame(height: 200)
                .cornerRadius(8)
                .shadow(radius: 2)

        }
        .onAppear {
            apiService
                .request(.getFlightDetail(flightID: self.flightID), with: Response<FlightDetail>.self)
                .sink(
                    receiveCompletion: { complete in
                        if case .failure(let error) = complete {
                            logger.error(error)
                        }
                }, receiveValue: { value in
                    self.flightDetail = value.value
                }
            )
                .add(to: self.disposeBag)
        }
        .navigationBarTitle(self.flightDetail.flight.flightNumber)
        .navigationBarItems(trailing:
            Button(action: {
                if self.store.state.settings.authenticateOnBoardingPassAppear {
                    authenticate(onSuccess: {
                        self.isBoardingPassViewPresented = true
                    })
                } else {
                    self.isBoardingPassViewPresented = true
                }
            }, label: {
                Image(systemName: "qrcode")
            })
                .frame(width: 44, height: 44, alignment: .center)
                .sheet(isPresented: $isBoardingPassViewPresented) {
                    BoardingPassView(flightID: self.flightID).environmentObject(self.store)
            }
        )
    }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDetailView(flightID: 1576738590792)
    }
}
