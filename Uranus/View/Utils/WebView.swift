//
//  WebView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://github.com/project-uranus")!))
    }
}
