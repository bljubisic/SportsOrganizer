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
    let firstname: String
    let lastname: String
    let username: String
    let phone: String
}

extension RegMessage {
    init() {
        firstname = ""
        lastname = ""
        username = ""
        phone = ""
    }
}

struct AddressBook {
    let name: String
    let phoneNum: [String]
}

extension AddressBook {
    init() {
        name = ""
        phoneNum = [String]()
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
    static let messageLens = Lens<CommMessage, Data> (
        get: { $0.message },
        set: { (m, cm) in CommMessage(message: m, state: cm.state) }
    )
    
    static let stateLens = Lens<CommMessage, State> (
        get: { $0.state },
        set: { (s, cm) in CommMessage(message: cm.message, state: s) }
    )
}

func compose <A, B, C> (lhs: Lens<A, B>, _ rhs: Lens<B, C>) -> Lens<A, C> {
    
    return Lens<A, C>(
        get: { a in rhs.get(lhs.get(a)) },
        set: { (c, a) in lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}

func * <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return compose(lhs: lhs, rhs)
}
precedencegroup AnotherLensPrecedenceGroup {
    associativity: left
}

precedencegroup LensPrecedenceGroup {
    associativity: left
    higherThan: AnotherLensPrecedenceGroup
}

infix operator *~ : LensPrecedenceGroup
func *~ <A, B> (lhs: Lens<A, B>, rhs: B) -> (A) -> A {
    return { a in lhs.set(rhs, a) }
}


infix operator |> : AnotherLensPrecedenceGroup
func |> <A, B> (x: A, f: (A) -> B) -> B {
    return f(x)
}

func |> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

