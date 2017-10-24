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
        var appMessage = Com_Sportorganizer_Proto_Msgs_AppMessage()
        appMessage.channelID = .hanshake
        appMessage.registrationRequest.firstName = message.firstname
        appMessage.registrationRequest.lastName = message.lastname
        appMessage.registrationRequest.username = message.username
        appMessage.registrationRequest.phoneNumber = message.phone
        appMessage.registrationRequest.alreadyRegistred = false
        var deviceInfo = Com_Sportorganizer_Proto_Msgs_DeviceInfo()
        deviceInfo.deviceName = "iPhone 7"
        deviceInfo.os = "iOS 10"
        deviceInfo.platform = "iOS"
        deviceInfo.processor = "A10"
        appMessage.registrationRequest.deviceInfo = deviceInfo
        do {
            print("Registration: \(appMessage.registrationRequest)")
            try socket.write(data: appMessage.serializedData())
        } catch let error {
            print("error: \(error)")
        }
        return true
    }
    
    func sendLogin(Message message: LoginMessage) -> Bool {
        if(!socket.isConnected && self.shouldReconnectFlag) {
            self.socket.connect()
        }
        
        var appMessage = Com_Sportorganizer_Proto_Msgs_AppMessage()
        appMessage.channelID = .hanshake
        appMessage.signIn.phoneNumber = message.phone🔢
        appMessage.signIn.password = message.password
        var deviceInfo = Com_Sportorganizer_Proto_Msgs_DeviceInfo()
        deviceInfo.deviceName = "iPhone 7"
        deviceInfo.os = "iOS 10"
        deviceInfo.platform = "iOS"
        deviceInfo.processor = "A10"
        appMessage.signIn.deviceInfo = deviceInfo
        do {
            print("Login: \(appMessage.signIn)")
            try socket.write(data: appMessage.serializedData())
        } catch let error {
            print("error: \(error)")
            return false
        }
        return true
    }
    
    func sendToken(Message message: TokenMessage) -> Bool {
        if(!socket.isConnected && self.shouldReconnectFlag) {
            self.socket.connect()
        }
        var appMessage = Com_Sportorganizer_Proto_Msgs_AppMessage()
        appMessage.channelID = .hanshake
        appMessage.registrationToken.phoneNumber = message.phone
        appMessage.registrationToken.token = message.token
        do {
            print("Registration: \(appMessage.registrationToken)")
            try socket.write(data: appMessage.serializedData())
        } catch let error {
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
    func websocketDidConnect(socket: WebSocketClient) {
        print("Connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("Disconnected: error: \(error.debugDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received text: \(text)")
        //textSubject.value = text
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data)")
        do {
            let appMessage = try Com_Sportorganizer_Proto_Msgs_AppMessage(serializedData: data)
            print(appMessage)
        } catch (let error) {
            print(error)
        }
        self.messagesData.value = data
    }
    
}

