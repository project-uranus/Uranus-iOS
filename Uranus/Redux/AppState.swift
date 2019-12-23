//
//  AppState.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/17.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import SwiftUI

struct AppState {
    var boardingPassToken: String?
    var personalInformation = PersonalInformation(legalName: "", firstName: "", lastName: "", email: "", IDNumber: "")
    var appearance: Appearance = Appearance()
    var settings: Settings = Settings()
    var messages: [Notification.Message] = [Notification.Message(title: "TEST", body: "TEST")]
    var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cmFudXMiLCJleHAiOjE1NzcxMTk2MzcsImlhdCI6MTU3NzAzMzIzNywicm9sZSI6InBhc3NlbmdlciIsImlkZW50aWZpZXIiOjE1NzY4OTYzODI1NjF9.OFjoYjnVNzUnxop8RpEilOXV3Zpd0ncm7mTLi4of5sY"
    var activeCounter: Int?
//    var activeFlight: FlightDetail
}

extension AppState {
    struct PersonalInformation {
        var legalName: String
        var firstName: String
        var lastName: String
        var email: String
        var IDNumber: String
        var avatar: UIImage? = UIImage.init(named: "Icon")
    }
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
