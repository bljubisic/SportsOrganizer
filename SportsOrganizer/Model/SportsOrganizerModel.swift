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
    var textSubject: Observable<CommMessage>!
    var modelState: Variable<State>
    var state: State
    private let disposeBag = DisposeBag()
    
    init() {

        communicationPortal = WebSocketCommunication(withURL: URL(string: "wss://localhost:8444/ws/app")!, shouldReconnect: true)
        self.communicationPortal.connect()
        self.state = .idle
        self.modelState = Variable(.idle)
        let messagesDataFiltered = self.communicationPortal.messagesData.asObservable().filter { (message) -> Bool in
            print("Message!!!")
            return (message != Data())
        }
        textSubject = Observable.combineLatest(modelState.asObservable(), messagesDataFiltered, resultSelector: { (state, message) -> CommMessage in
            print("Message received: \(message) and state is \(state)")
            return CommMessage(message: message, state: state)
        })
        communicationPortal.set(Model: self)
    }
    
    func send(message: Message) {
        _ = self.communicationPortal.send(Message: message)
    }
    
    func sendRegistration(message: RegMessage) {
        _ = self.communicationPortal.sendRegistration(Message: message)
    }
    
    func create(message: Message) -> Bool {
        return true
    }
    
    func changeState(from state: State, to: State) {
        
    }
    
}

