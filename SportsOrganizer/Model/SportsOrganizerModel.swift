//
//  SportsOrganizerModel.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 3/31/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import Starscream
import RxSwift

public class SportsOrganizerModel: SOModelProtocol {
    
    var communicationPortal: CommunicationProtocol
    var textSubject: Variable<CommMessage>
    var state: State
    
    init() {
        
        communicationPortal = WebSocketCommunication(withURL: URL(string: "wss://localhost:8444/ws/app")!)
        self.communicationPortal.shouldReconnect(flag: true)
        textSubject = Variable(CommMessage(message: Data(), state: .idle))
        self.communicationPortal.connect()
        self.state = .idle
        
        
        _ = self.communicationPortal.messagesData.asObservable().map{ (data) -> CommMessage in
            return CommMessage(message: data, state: .initialState)
            }.subscribe(onNext: { (message) in
                self.textSubject.value = message
            })
    }
    
    func send(message: Message) {
        _ = self.communicationPortal.send(Message: message)
    }
    
    func create(message: Message) -> Bool {
        return true
    }
    
}

