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
        TabView {
            ScheduleRootView()
                .tabItem {
                    if self.store.state.appearance.onShowTabBar {
                        Image(systemName: "airplane")
                            .font(.headline)
                    }
            }
            .tag(0)
            MineRootView()
                .tabItem {
                    if self.store.state.appearance.onShowTabBar {
                        Image(systemName: "person.crop.square")
                            .font(.headline)
                    }
            }
            .tag(1)
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
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
