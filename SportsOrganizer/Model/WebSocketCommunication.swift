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

final class WebSocketCommunication: CommunicationProtocol  {
    
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
    
    func send(Message message: CommMessage) -> Bool {
        if(!socket.isConnected && self.shouldReconnectFlag) {
            self.socket.connect()
        }
        socket.write(data: message.message)
        return true
    }
    
    func sendRegistration(Message message: RegMessage) -> Bool {
        if(!socket.isConnected && self.shouldReconnectFlag) {
            self.socket.connect()
        }
        var registrationRequestBuilder = Com_Sportorganizer_Proto_Msgs_RegistrationRequest()
        registrationRequestBuilder.firstName = message.firstname
        registrationRequestBuilder.lastName = message.lastname
        registrationRequestBuilder.username = message.username
        registrationRequestBuilder.phoneNumber = message.phone
        registrationRequestBuilder.alreadyRegistred = false
        var deviceInfo = Com_Sportorganizer_Proto_Msgs_DeviceInfo()
        deviceInfo.deviceName = "iPhone 7"
        deviceInfo.os = "iOS 10"
        deviceInfo.platform = "iOS"
        deviceInfo.processor = "A10"
        registrationRequestBuilder.deviceInfo = deviceInfo
        do {
            print("Registration: \(registrationRequestBuilder)")
            try socket.write(data: registrationRequestBuilder.serializedData())
        } catch let error as Error {
            print("error: \(error)")
        }
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

