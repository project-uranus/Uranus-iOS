//
//  AppReducer.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/17.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

func reducer(state: AppState, action: AppAction) -> AppState {
    var appState = state

    switch action.type {
    case .readBoardingPass:
        guard let payload = action.payload as? String else { break }
        appState.boardingPassToken = payload
    case .updatePersonalInformation:
        guard let payload = action.payload as? PersonalInformation else { break }
        appState.personalInformation = payload
    case .hideBottomBar:
        guard let payload = action.payload as? Bool else { break }
        appState.appearance.onShowTabBar = payload
    case .toggleAuthenticateOnBoardingPassAppear:
        guard let payload = action.payload as? Bool else { break }
        appState.settings.authenticateOnBoardingPassAppear = payload
    case .logout:
        appState = .init()
    case .updateActiveCounter:
        guard let payload = action.payload as? Int? else { break }
        appState.activeCounter = payload
    case .appendMessage:
        guard let payload = action.payload as? Notification.Message else { break }
        appState.messages.append(payload)
    }
    return appState
}
