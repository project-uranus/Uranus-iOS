//
//  PersonalInformation.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/24.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import SwiftUI

struct PersonalInformation: Codable {
    var legalName: String
    var firstName: String
    var lastName: String
    var email: String
    var IDNumber: String
    var avatar: UIImage? = UIImage.init(named: "Icon")

    enum CodingKeys: String, CodingKey {
        case legalName = "name"
        case firstName
        case lastName
        case email
        case IDNumber = "idNumber"
    }
}
