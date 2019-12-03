//
//  ScheduleItemView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/3.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct ScheduleItemView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .opacity(0.05)
            VStack {
                StatusChipView(status: .canceled)
                HStack {
                    Text("2019-12-19 17:15")
                        .font(.caption)
                    Spacer()
                    Text("2019-12-19 20:40")
                        .font(.caption)
                }
                HStack {
                    VStack {
                        Text("上海浦东国际机场T1")
                            .bold()
                        Text("PVG")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "airplane")
                    Spacer()
                    VStack {
                        Text("中部国际机场")
                            .bold()
                        Text("NGO")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("中国东方航空 · MU291 · Airbus A320")
                        .font(.footnote)
                    Spacer()
                }
            }
            .padding(16)
        }
    }
}

struct ScheduleItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ScheduleItemView()
            ScheduleItemView()
        }
    }
}
