//
//  AppAction.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/17.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct AppAction {
    let type: ActionType
    let payload: Any?

    init(type: ActionType, payload: Any?) {
        self.type = type
        self.payload = payload
    }
}

enum ActionType {
    case readBoardingPass
    case readPersonalInformation
}