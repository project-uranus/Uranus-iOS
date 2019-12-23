//
//  AppState.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/17.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct AppState {
    var boardingPassToken: String?
    var personalInformation = PersonalInformation(legalName: "", firstName: "", lastName: "", email: "", IDNumber: "")
    var appearance: Appearance = Appearance()
    var settings: Settings = Settings()
    var messages: [Notification.Message] = []
    var activeCounter: Int?
}

extension AppState {
    struct Appearance {
        var onShowTabBar: Bool = true
    }
}

extension AppState {
    struct Settings {
        var authenticateOnBoardingPassAppear: Bool = true
    }
}
