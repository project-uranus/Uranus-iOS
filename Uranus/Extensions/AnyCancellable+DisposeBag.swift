//
//  AnyCancellable+DisposeBag.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/22.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation
import Combine

// Reference: https://www.appsdissected.com/save-sink-assign-subscriber-anycancellable/
extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}

class DisposeBag {
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}
