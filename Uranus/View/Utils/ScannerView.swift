//
//  ScannerView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/18.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ScannerView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ScannerView>) -> PreviewView {
        PreviewView()
    }

    func updateUIView(_ uiView: PreviewView, context: UIViewRepresentableContext<ScannerView>) {

    }
}

public class PreviewView: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?

    override public func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}
