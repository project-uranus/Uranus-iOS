//
//  EditPersonalInformationView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/19.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import PKHUD

struct EditPersonalInformationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var store: AppStore

    @State var personalInformation: PersonalInformation
    @State private var isPresented: Bool = false

    var disposeBag = DisposeBag()

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "n.square.fill")
                        Text("法定姓名")
                        Spacer()
                        TextField("法定姓名", text: $personalInformation.legalName)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.namePhonePad)
                    }
                    HStack {
                        Image(systemName: "f.square.fill")
                        Text("名（罗马字母）")
                        Spacer()
                        TextField("名（罗马字母）", text: $personalInformation.firstName)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.namePhonePad)
                    }
                    HStack {
                        Image(systemName: "l.square.fill")
                        Text("姓（罗马字母）")
                        Spacer()
                        TextField("姓（罗马字母）", text: $personalInformation.lastName)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.namePhonePad)
                    }
                    HStack {
                        Image(systemName: "envelope")
                        Text("邮箱")
                        Spacer()
                        TextField("邮箱", text: $personalInformation.email)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.emailAddress)
                    }
                    HStack {
                        Image(systemName: "signature")
                        Text("护照号码")
                        Spacer()
                        TextField("护照号码", text: $personalInformation.IDNumber)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                Section {
                    Button(action: {
                        apiService
                            .request(.updatePersonalInformation(information: self.personalInformation), with: Common.self)
                            .sink(
                                receiveCompletion: { complete in
                                    if case .failure(let error) = complete {
                                        logger.error(error)
                                    }
                            }, receiveValue: { _ in
                                self.store.dispatch(
                                    action: .init(
                                        type: ActionType.updatePersonalInformation,
                                        payload: self.personalInformation
                                    )
                                )
                                DispatchQueue.main.async {
                                    HUD.flash(.success, delay: 1.0)
                                }
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        )
                            .add(to: self.disposeBag)
                    }, label: {
                        Text("提交")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    })
                        .buttonStyle(BorderlessButtonStyle())
                        .background(Color.theme)
                        .cornerRadius(8)
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
        EditPersonalInformationView(personalInformation: PersonalInformation(legalName: "", firstName: "", lastName: "", email: "", IDNumber: ""))
    }
}
