//
//  Message.swift
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

struct RegMessage {
    let name: String
    let sport: String
    let birthday: Date
    let country: String
    let phone: String
}

extension RegMessage {
    init() {
        name = ""
        sport = ""
        birthday = Date()
        country = ""
        phone = ""
    }
}

enum State {
    case initialState
    case sendingMessage
    case waitingResponse
    case idle
    
    mutating func changeState(from: State, to: State) {
        // TODO: For now let this be like this, but should be changed with rules when and how state could be changed
        switch self {
        case .idle: self = .initialState
        case .initialState: self = .sendingMessage
        case .sendingMessage: self = .waitingResponse
        case .waitingResponse: self = .idle
        }
    }
}

public struct CommMessage {
    let message: Data
    let state: State
}

extension CommMessage {
    init() {
        message = Data()
        state = .idle
    }
}

extension CommMessage {
    static let commMessageLens = Lens<CommMessage, Data> (
        get: { $0.message },
        set: { (m, cm) in CommMessage(message: m, state: cm.state) }
    )
    
    static let commStateLens = Lens<CommMessage, State> (
        get: { $0.state },
        set: { (s, cm) in CommMessage(message: cm.message, state: s) }
    )
}
