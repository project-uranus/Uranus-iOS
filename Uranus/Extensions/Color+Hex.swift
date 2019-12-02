//
//  Color+Hex.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/2.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let red = Double((hex & 0xFF0000) >> 16) / 255
        let green = Double((hex & 0x00FF00) >> 8) / 255
        let blue  = Double(hex & 0x0000FF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
