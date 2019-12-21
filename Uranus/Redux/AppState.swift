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
    var messages: [Message] = [Message(time: .init(timeIntervalSince1970: 1576746900), title: "TEST", body: "TEST")]
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
