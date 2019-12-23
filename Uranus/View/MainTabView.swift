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

    var disposeBag = DisposeBag()

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
                apiService
                    .request(.getPersonalInformation, with: Response<PersonalInformation>.self)
                    .sink(
                        receiveCompletion: { complete in
                            if case .failure(let error) = complete {
                                logger.error(error)
                            }
                    }, receiveValue: { value in
                        self.store.dispatch(
                            action: .init(
                                type: ActionType.updatePersonalInformation,
                                payload: value.value
                            )
                        )
                    }
                )
                    .add(to: self.disposeBag)
            }
            WebSocketView(url: URL(string: "ws://10.0.0.116:5000/notification/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cmFudXMiLCJleHAiOjE1Nzk3MTE5MjIsImlhdCI6MTU3NzExOTkyMiwicm9sZSI6InBhc3NlbmdlciIsImlkZW50aWZpZXIiOjE1NzY4OTYzODI1NjF9.lcq00eAI-K17hx-rtyh-9DZac7CefJaszj0Tmw68hPk")!)
                .frame(width: 0, height: 0)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
