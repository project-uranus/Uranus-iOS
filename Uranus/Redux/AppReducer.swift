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

    switch action {
    case .readBoardingPass:
        appState.boardingPassToken = "M1DESMARAIS/LUC EABC123 YULFRAAC 0834 226F001A0025 100"
    }

    return appState
}
