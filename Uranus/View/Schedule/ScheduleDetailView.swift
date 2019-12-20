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
        HUD.flash(.labeledError(title: "错误", subtitle: "No biometrics."), delay: 1.0)
        #endif
    }
}

struct ScheduleDetailView: View {
    @EnvironmentObject private var store: AppStore

    @State private var isPresented: Bool = false

    var buttonGroup: some View {
        HStack {
            Button(action: {
                let eventStore = EKEventStore()
                eventStore.requestAccess(to: .event) { granted, _ in
                    if granted {
                        eventStore.addEvent(
                            flight: Flight(
                                dateOfFlight: Date(),
                                flightNumber: "MU291",
                                departureTime: .init(timeIntervalSince1970: 1576746900),
                                arrivalTime: .init(timeIntervalSince1970: 1576759200),
                                fromCityAirportCode: "PVG",
                                toCityAirportCode: "NGO"
                            ),
                            alertTime: nil
                        )
                    } else {

                    }
                }
            }, label: {
                HStack {
                    Image(systemName: "calendar")
                    Text("添加到日历")
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            })
                .background(Color.theme.opacity(0.25))
                .cornerRadius(4)
            Spacer()
                .frame(width: 10)
            Button(action: {

            }, label: {
                HStack {
                    Image(systemName: "person.crop.circle.badge.checkmark")
                    Text("值机")
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            })
                .background(Color.theme.opacity(0.25))
                .cornerRadius(4)
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
                            Text("17:15")
                                .font(.caption)
                            Spacer()
                            Text("20:40")
                                .font(.caption)
                            Spacer()
                        }
                        TimeLine(radius: 3)
                            .frame(width: 6)
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("上海浦东国际机场 T1")
                            Text("PVG T1")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("中部国际机场")
                            Text("NGO")
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
                        Text("中国东方航空")
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
                        StatusChip(status: .scheduled)
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
                        Text("2019-12-19")
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
                        Text("16:30")
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
                        Text("Y")
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
                        Text("13H")
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
                        Text("2")
                            .font(.title)
                    }
                    .padding()
                }
            }
            MapView(
                originAirport: Airport(IATA: "PVG", name: "上海浦东国际机场", position: "上海", coordinate: .init(latitude: 31.143333, longitude: 121.805278)),
                destinationAirport: Airport(IATA: "NGO", name: "中部国际机场", position: "名古屋", coordinate: .init(latitude: 34.858333, longitude: 136.805278))
            )
                .frame(height: 200)
                .cornerRadius(4)
                .shadow(radius: 2)

        }
        .navigationBarTitle("MU291")
        .navigationBarItems(trailing:
            Button(action: {
                if self.store.state.settings.authenticateOnBoardingPassAppear {
                    authenticate(onSuccess: {
                        self.isPresented = true
                    })
                } else {
                    self.isPresented = true
                }
            }, label: {
                Image(systemName: "qrcode")
            })
                .frame(width: 44, height: 44, alignment: .center)
                .sheet(isPresented: $isPresented) {
                    BoardingPassView().environmentObject(self.store)
            }
        )
    }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDetailView()
    }
}
