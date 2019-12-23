//
//  Notification.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import Foundation

struct Notification: Decodable {
    let type: String
    let message: Message
}

extension Notification {
    struct Message: Decodable {
        let uuid: UUID = .init()
        let time: Date = .init()
        let title: String
        let body: String

        enum CodingKeys: String, CodingKey {
            case title
            case body
        }
    }
}
