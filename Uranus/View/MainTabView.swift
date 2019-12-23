//
//  MainTabView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject private var store: AppStore

    var body: some View {
        VStack {
            TabView {
                ScheduleRootView()
                    .tabItem {
                        if self.store.state.appearance.onShowTabBar {
                            Image(systemName: "airplane")
                                .font(.headline)
                        }
                }
                .tag(0)
                MessageRootView()
                    .tabItem {
                        if self.store.state.appearance.onShowTabBar {
                            Image(systemName: "message.fill")
                                .font(.headline)
                        }
                }
                .tag(1)
                MineRootView()
                    .tabItem {
                        if self.store.state.appearance.onShowTabBar {
                            Image(systemName: "person.crop.square")
                                .font(.headline)
                        }
                }
                .tag(2)
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                self.store.dispatch(
                    action: .init(
                        type: ActionType.readPersonalInformation,
                        payload: AppState.PersonalInformation(
                            legalName: "John Doe",
                            firstName: "JOHN",
                            lastName: "DOE",
                            email: "john.doe@example.com",
                            IDNumber: "00000000"
                        )
                    )
                )
            }
            WebSocketView(url: URL(string: "ws://202.120.40.8:30379/notification/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cmFudXMiLCJleHAiOjE1NzcxMTk2MzcsImlhdCI6MTU3NzAzMzIzNywicm9sZSI6InBhc3NlbmdlciIsImlkZW50aWZpZXIiOjE1NzY4OTYzODI1NjF9.OFjoYjnVNzUnxop8RpEilOXV3Zpd0ncm7mTLi4of5sY")!)
                .frame(width: 0, height: 0)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
