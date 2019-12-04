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
        HStack {
            ZStack {
                Panel()
                VStack {
                    HStack {
                        StatusChip(status: .canceled)
                        Spacer()
                    }
                    HStack {
                        Text("2019-12-19 17:15")
                            .font(.caption)
                        Spacer()
                        Text("2019-12-19 20:40")
                            .font(.caption)
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Text("上海")
                                .bold()
                            Text("SHA")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "airplane")
                        Spacer()
                        VStack {
                            Text("名古屋")
                                .bold()
                            Text("NGO")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("中国东方航空 · MU291 · Airbus A320")
                            .font(.footnote)
                        Spacer()
                    }
                }
                .padding(16)
            }
            NavigationLink(destination: ScheduleDetailView()) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
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
