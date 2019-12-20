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

    @State private var isSheetPresented: Bool = false
    @State private var isActionSheetPresented: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?

    private var personalInformation: AppState.PersonalInformation { store.state.personalInformation }

    var body: some View {
        List {
            Section(header: Text("")) {
                HStack {
                    Spacer()
                    Image(uiImage: store.state.personalInformation.avatar!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .padding(2)
                        .shadow(radius: 4)
                        .cornerRadius(8)
                        .onTapGesture(perform: {
                            self.isActionSheetPresented = true
                        })
                        .actionSheet(isPresented: $isActionSheetPresented) {
                            ActionSheet(
                                title: Text("修改头像"),
                                buttons: [
                                    .default(Text("相机胶卷")) {
                                        self.sourceType = .photoLibrary
                                        self.isImagePickerPresented = true
                                    },
                                    .default(Text("拍照")) {
                                        self.sourceType = .camera
                                        self.isImagePickerPresented = true
                                    },
                                    .destructive(Text("取消"))
                            ])
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(image: self.$store.state.personalInformation.avatar, sourceType: self.$sourceType)
                    }
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
                self.isSheetPresented = true
            }, label: {
                Text("修改个人信息")
            })
        )
            .modifier(HideBottomBarWhenPushed())
            .sheet(isPresented: $isSheetPresented) {
                EditPersonalInformationView().environmentObject(self.store)
        }
    }
}

struct PersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationView()
    }
}
