//
//  PersonalInformationView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/13.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PersonalInformationView: View {
    @EnvironmentObject private var store: AppStore
    private var personalInformation: AppState.PersonalInformation { store.state.personalInformation }

    var body: some View {
        List {
            Section(header: Text("")) {
                HStack {
                    Spacer()
                    KFImage(URL(string: "https://avatars0.githubusercontent.com/u/18243819?s=460&v=4")!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 8)
                        .cornerRadius(8)
                        .onTapGesture(perform: {
                        })
                    Spacer()
                }
            }
            Section {
                HStack {
                    Image(systemName: "n.square.fill")
                    Text("法定姓名")
                    Spacer()
                    Text(personalInformation.legalName)
                }
                HStack {
                    Image(systemName: "f.square.fill")
                    Text("名（罗马字母）")
                    Spacer()
                    Text(personalInformation.firstName)
                }
                HStack {
                    Image(systemName: "l.square.fill")
                    Text("姓（罗马字母）")
                    Spacer()
                    Text(personalInformation.lastName)
                }
                HStack {
                    Image(systemName: "envelope")
                    Text("邮箱")
                    Spacer()
                    Text(personalInformation.email)
                }
                HStack {
                    Image(systemName: "signature")
                    Text("护照号码")
                    Spacer()
                    Text(personalInformation.IDNumber)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("个人信息")
        .navigationBarItems(trailing:
            Button(action: {
            }, label: {
                Text("修改个人信息")
            })
        )
    }
}

struct PersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationView()
    }
}
