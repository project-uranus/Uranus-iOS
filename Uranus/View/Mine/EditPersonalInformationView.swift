//
//  EditPersonalInformationView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/19.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct EditPersonalInformationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var store: AppStore

    @State private var isPresented: Bool = false
//    @State private var personalInformation: AppState.PersonalInformation

    private var personalInformationBinding: Binding<AppState.PersonalInformation> { $store.state.personalInformation }

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "n.square.fill")
                        Text("法定姓名")
                        Spacer()
                        TextField("法定姓名", text: personalInformationBinding.legalName)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.namePhonePad)
                    }
                    HStack {
                        Image(systemName: "f.square.fill")
                        Text("名（罗马字母）")
                        Spacer()
                        TextField("名（罗马字母）", text: personalInformationBinding.firstName)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.namePhonePad)
                    }
                    HStack {
                        Image(systemName: "l.square.fill")
                        Text("姓（罗马字母）")
                        Spacer()
                        TextField("姓（罗马字母）", text: personalInformationBinding.lastName)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.namePhonePad)
                    }
                    HStack {
                        Image(systemName: "envelope")
                        Text("邮箱")
                        Spacer()
                        TextField("邮箱", text: personalInformationBinding.email)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.emailAddress)
                    }
                    HStack {
                        Image(systemName: "signature")
                        Text("护照号码")
                        Spacer()
                        TextField("护照号码", text: personalInformationBinding.IDNumber)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                Section {
                    Button(action: {

                    }, label: {
                        Text("提交")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    })
                        .background(Color.theme)
                        .cornerRadius(4)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("返回")
                })
            )
        }
    }
}

struct EditPersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonalInformationView()
    }
}
