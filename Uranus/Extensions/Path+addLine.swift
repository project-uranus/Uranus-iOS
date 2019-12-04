//
//  Path+addLine.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/4.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI

public extension Path {
    // swiftlint:disable identifier_name
    mutating func addLine(from p1: CGPoint, to p2: CGPoint) {
        self.move(to: p1)
        self.addLine(to: p2)
    }
}
