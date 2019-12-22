//
//  StatusChip.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/3.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

enum FlightStatus: String, Codable {
    case scheduled
    case delayed
    case boarding
    case departed
    case arrived
    case cancelled
    case noTakeoffInfo

    var color: Color {
        switch self {
        case .scheduled:
            return .blue
        case .delayed:
            return .orange
        case .boarding:
            return .yellow
        case .departed:
            return .green
        case .arrived:
            return .green
        case .cancelled:
            return .red
        case .noTakeoffInfo:
            return .gray
        }
    }

    var text: String {
        switch self {
        case .scheduled:
            return "已排定"
        case .delayed:
            return "已延误"
        case .boarding:
            return "登机中"
        case .departed:
            return "已出发"
        case .arrived:
            return "已到达"
        case .cancelled:
            return "已取消"
        case .noTakeoffInfo:
            return "无"
        }
    }
}

struct StatusChip: View {
    @State var status: FlightStatus

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8).foregroundColor(status.color)
                Text(status.text)
                    .font(.caption)
                    .foregroundColor(.white)
                    .background(Color.clear)
                    .padding(2)
            }
            .frame(maxWidth: 64)
        }
    }
}

struct StatusChip_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StatusChip(status: .scheduled)
            StatusChip(status: .delayed)
            StatusChip(status: .boarding)
            StatusChip(status: .departed)
            StatusChip(status: .arrived)
            StatusChip(status: .cancelled)
            StatusChip(status: .noTakeoffInfo)
        }
    }
}
