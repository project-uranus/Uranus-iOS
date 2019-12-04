//
//  TimeLine.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/4.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

struct Line: Shape {
    let offset: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLine(
                from: CGPoint(x: rect.width * 0.5, y: rect.height * 0.25 + offset),
                to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.75 - offset)
            )
        }
    }
}

struct TimeLine: View {
    let radius: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill()
                    .frame(width: self.radius * 2, height: self.radius * 2)
                    .position(x: self.radius * 0.5, y: geometry.size.height * 0.25)
                Line(offset: self.radius)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [6, 3]))
                Circle()
                    .fill()
                    .frame(width: self.radius * 2, height: self.radius * 2)
                    .position(x: self.radius * 0.5, y: geometry.size.height * 0.75)
            }
            .opacity(0.25)
            .frame(maxWidth: self.radius)
        }
    }
}

struct TimeLine_Previews: PreviewProvider {
    static var previews: some View {
        TimeLine(radius: 3)
            .padding()
    }
}
