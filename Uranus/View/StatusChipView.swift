//
//  StatusChipView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/3.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

enum Status {
    case unstarted
    case canceled

    var color: Color {
        switch self {
        case .unstarted:
            return .gray
        case .canceled:
            return .red
        }
    }

    var text: String {
        switch self {
        case .unstarted:
            return "未出行"
        case .canceled:
            return "已取消"
        }
    }
}

struct StatusChipView: View {
    @State var status: Status

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 4).foregroundColor(status.color)
                Text(status.text)
                    .font(.caption)
                    .foregroundColor(.white)
                    .background(Color.clear)
                    .padding(2)
            }
            .frame(maxWidth: 64)
            Spacer()
        }
    }
}

struct StatusChipView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StatusChipView(status: .unstarted)
            StatusChipView(status: .canceled)
        }
    }
}
