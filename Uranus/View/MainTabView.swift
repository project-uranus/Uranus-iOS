//
//  MainTabView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/1.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        TabView {
            ScheduleRootView().tabItem {
                Image(systemName: "airplane")
                Text("行程")
            }
            MineRootView().tabItem {
                Image(systemName: "person.crop.square")
                Text("我的")
            }
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
