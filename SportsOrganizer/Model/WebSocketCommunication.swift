//
//  WebSocketCommunication.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/7/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import Starscream
import RxSwift

public class WebSocketCommunication: CommunicationProtocol  {
    
    var socket: WebSocket
    var shouldReconnectFlag: Bool
    var messagesData: Variable<Data>
    var model: SOModelProtocol!
    
    
    init(withURL url: URL, shouldReconnect: Bool) {
        self.socket =  WebSocket(url: url)
        self.shouldReconnectFlag = shouldReconnect
        self.messagesData = Variable(Data())
        self.model = nil
    }
    
    func set(Model model: SOModelProtocol) {
        self.model = model
    }
    
    func connect() {
        self.socket.delegate = self
        self.socket.disableSSLCertValidation = true
        self.socket.connect()
    }
    
    func send(Message message: Message) -> Bool {
        if(!socket.isConnected && self.shouldReconnectFlag) {
            self.socket.connect()
        }
        socket.write(string: message.message)
        return true
    }
    
    func sendRegistration(Message message: RegMessage) -> Bool {
        if(!socket.isConnected && self.shouldReconnectFlag) {
            self.socket.connect()
        }
        let registrationRequestBuilder = Com.Sportorganizer.Proto.Msgs.RegistrationRequest.Builder()
        registrationRequestBuilder.setFirstName(message.name)
        registrationRequestBuilder.setLastName(message.name)
        registrationRequestBuilder.setUsername(message.name)
        registrationRequestBuilder.setPhoneNumber(message.phone)
        registrationRequestBuilder.setAlreadyRegistred(false)
        let registrationRequest = registrationRequestBuilder.getMessage()
        socket.write(data: registrationRequest.data())
        return true
    }
    
    func status() -> CommunicationStatus {
        if(socket.isConnected) {
            return .connected
        }
        else {
            return .disconnected
        }
    }

}

extension WebSocketCommunication: WebSocketDelegate {
    
    public func websocketDidConnect(socket: WebSocket) {
        print("Connected")
    }
    
    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("Disconnected: error: \(error.debugDescription)")
    }
    
    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("Received text: \(text)")
        //textSubject.value = text
    }
    
    public func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("Received data: \(data)")
        var state = self.model.modelState.value
        state.changeState(from: state, to: .initialState)
        self.model.modelState.value = state
        self.messagesData.value = data
    }
    
}

