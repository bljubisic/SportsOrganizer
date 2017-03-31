//
//  MessageStruct.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 3/30/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

public struct Message {
    let message: String
    let timeStamp: Date
}

extension Message {
    init() {
        message = ""
        timeStamp = Date()
    }
}

extension Message {
    static let messageLens = Lens<Message, String> (
        get: { $0.message },
        set: { (m, wm) in Message(message: m, timeStamp: wm.timeStamp) }
    )
}
