//
//  MessageItemView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct MessageItemView: View {
    @State var message: Message

    var body: some View {
        HStack(alignment: .top) {
            Image("Icon")
                .resizable()
                .frame(width: 64, height: 64)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .padding(2)
                .shadow(radius: 4)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(message.time.toString())
                    .font(.caption)
                    .foregroundColor(.gray)
                ZStack {
                    Panel()
                    VStack(alignment: .leading) {
                        HStack {
                            Text(message.title)
                                .font(.callout)
                                .bold()
                            Spacer()
                        }
                        Text(message.body)
                    }
                    .padding(8)
                }
            }
        }
    }
}

struct MessageItemView_Previews: PreviewProvider {
    static var previews: some View {
        MessageItemView(message: Message(time: .init(timeIntervalSince1970: 1576746900), title: "TEST", body: "TEST"))
    }
}
