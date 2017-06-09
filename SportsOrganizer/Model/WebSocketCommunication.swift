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
    
    
    init(withURL url: URL) {
        socket =  WebSocket(url: url)
        shouldReconnectFlag = false
        messagesData = Variable("Init".data(using: String.defaultCStringEncoding)!)
    }
    
    func connect() {
        self.socket.delegate = self
        self.socket.disableSSLCertValidation = true
        self.socket.connect()
    }
    
    func send(Message message: Message) -> Bool {
        socket.write(string: message.message)
        return true
    }
    
    func status() -> CommunicationStatus {
        return .connected
    }
    
    func shouldReconect(flag: Bool) -> Void {
        self.shouldReconectFlag = flag
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
        self.messagesData.value = data
        
    }
    
}

