//
//  ScheduleDetailView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/4.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct ScheduleDetailView: View {
    var body: some View {
        List {
            ZStack {
                Panel()
                HStack {
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("17:15")
                            .font(.caption)
                        Spacer()
                        Text("20:40")
                            .font(.caption)
                        Spacer()
                    }
                    TimeLine(radius: 3)
                        .frame(width: 6)
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("上海浦东国际机场 T1")
                        Text("PVG T1")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("中部国际机场")
                        Text("NGO")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            }
            HStack {
                ZStack {
                    Panel()
                    VStack {
                        Text("舱位")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Y")
                            .font(.title)
                    }
                    .padding()
                }
                Spacer()
                ZStack {
                    Panel()
                    VStack {
                        Text("座位号")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("13H")
                            .font(.title)
                    }
                    .padding()
                }
                Spacer()
                ZStack {
                    Panel()
                    VStack {
                        Text("状态")
                            .font(.caption)
                            .foregroundColor(.gray)
                        StatusChip(status: .unstarted)
                    }
                    .padding()
                }
            }
            MapView()
                .frame(height: 200)
                .cornerRadius(4)
                .shadow(radius: 2)
        }
        .navigationBarTitle("MU291")
    }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDetailView()
    }
}
