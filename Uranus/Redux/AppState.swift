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
}

extension AppState {
    struct PersonalInformation {
        var legalName: String
        var firstName: String
        var lastName: String
        var email: String
        var IDNumber: String
    }
}
