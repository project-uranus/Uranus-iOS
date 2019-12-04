//
//  Panel.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/4.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct Panel: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            if colorScheme == .light {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(radius: 2)
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .opacity(0.05)
            }
        }
    }
}

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        Panel()
    }
}
