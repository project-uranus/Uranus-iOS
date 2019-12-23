//
//  ScheduleRootView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct ScheduleRootView: View {
    @EnvironmentObject private var store: AppStore

    @State private var flightList: [Flight] = []
    @State private var searchText: String = ""
    @State private var isPresented: Bool = false
    @State private var token: String?
    @State private var index: Int = 0

    var disposeBag = DisposeBag()
    private let images = ["PageView-0", "PageView-1", "PageView-2"]

    var body: some View {
        NavigationView {
            List {
                TextField("搜索", text: $searchText)
                    .textFieldStyle(SearchTextFieldStyle())
                PageView(index: $index.animation(), maxIndex: images.count - 1) {
                    ForEach(self.images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .aspectRatio(16/9, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                ForEach(flightList, id: \.self.id) { flight in
                    ScheduleItemView(flight: flight)
                }
            }
            .onAppear {
                apiService
                    .request(.getFlightList, with: Response<[Flight]>.self)
                    .sink(
                        receiveCompletion: { complete in
                            if case .failure(let error) = complete {
                                logger.error(error)
                            }
                    }, receiveValue: { value in
                        self.flightList = value.value
                    }
                )
                    .add(to: self.disposeBag)
            }
            .navigationBarTitle("行程")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented = true
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                })
                    .frame(width: 44, height: 44, alignment: .center)
                    .sheet(isPresented: $isPresented) {
                        ZStack {
                            ScannerView(token: self.$token)
                            if self.token != nil {
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black)
                                            .opacity(0.8)
                                        Text(self.token?.decode().passengerID ?? "")
                                            .font(.title)
                                            .padding()
                                    }
                                    .frame(width: 200, height: 100)
                                    Button(action: {
                                        apiService
                                            .request(.updatePassengerStatus(passengerID: self.token?.decode().passengerName ?? "", status: 8), with: BoardingPass.self)
                                            .sink(
                                                receiveCompletion: { complete in
                                                    if case .failure(let error) = complete {
                                                        logger.error(error)
                                                    }
                                            }, receiveValue: { _ in
                                            }
                                        )
                                            .add(to: self.disposeBag)
                                        self.token = nil
                                    }, label: {
                                        Text("确认")
                                            .foregroundColor(.white)
                                            .frame(minWidth: 0, maxWidth: 200)
                                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                                    })
                                        .buttonStyle(BorderlessButtonStyle())
                                        .background(Color.theme)
                                        .cornerRadius(8)
                                }
                            }
                        }
                }
            )
        }
    }
}

struct ScheduleRootView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleRootView()
    }
}
