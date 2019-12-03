//
//  SearchTextFieldStyle.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/3.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct SearchTextFieldStyle: TextFieldStyle {
    // swiftlint:disable identifier_name
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 4).opacity(0.05))
    }
}
