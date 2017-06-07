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
    
    init() {
        
        communicationPortal = WebSocketCommunication(withURL: URL(string: "wss://localhost:8444/ws/app")!)
        textSubject = Variable(CommMessage(message: Data(), state: .idle))
        self.communicationPortal.connect()
    }
    
    func send(message: Message) {
        _ = self.communicationPortal.send(Message: message)
    }
    
    func create(message: Message) -> Bool {
        return true
    }
    
}

