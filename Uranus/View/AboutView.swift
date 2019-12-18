//
//  AboutView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/2.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var acknowledgement: some View {
        VStack {
            Text("iOS")
                .font(.footnote)
                .foregroundColor(.theme)
            Text("Yuchen Cheng (@rudeigerc)")
                .font(.caption)
                .bold()
            Spacer()
            Text("Middleware")
                .font(.footnote)
                .foregroundColor(.theme)
            Text("Xin Zhou (@cigui)")
                .font(.caption)
                .bold()
            Spacer()
            Text("Web")
                .font(.footnote)
                .foregroundColor(.theme)
            Text("Meixian Jiang (@jiangmeixian)")
                .font(.caption)
                .bold()
        }
    }

    var body: some View {
        ScrollView {
            Image("Icon")
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .padding()
                .shadow(color: colorScheme == .dark ? .white : .black, radius: 4)
            Text("Uranus")
                .font(.custom("Apple Chancery", size: 36))
                .bold()
            Spacer()
            Text("Project Uranus")
                .font(.callout)
                .foregroundColor(.gray)
            Spacer()
            acknowledgement
            Spacer()
            Text("https://github.com/project-uranus")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .modifier(HideBottomBarWhenPushed())
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
