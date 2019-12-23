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
    case hideBottomBar
    case readBoardingPass
    case updatePersonalInformation
    case toggleAuthenticateOnBoardingPassAppear
    case logout
    case updateActiveCounter
    case appendMessage
}
