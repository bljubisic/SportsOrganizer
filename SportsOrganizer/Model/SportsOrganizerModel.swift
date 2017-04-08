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
    
    var socket: WebSocket
    var textSubject: Variable<String>
    
    init() {
        socket = WebSocket(url: URL(string: "ws://echo.websocket.org")!)
        textSubject = Variable("Start")
    }
    
    func send(message: Message) {
        socket.write(string: message.message)
    }
    
    func create(message: Message) -> Bool {
        return true
    }
    
}

extension SportsOrganizerModel: WebSocketDelegate {
    
    public func websocketDidConnect(socket: Starscream.WebSocket) {
        
    }
    
    public func websocketDidDisconnect(socket: Starscream.WebSocket, error: NSError?) {
        
    }
    
    public func websocketDidReceiveMessage(socket: Starscream.WebSocket, text: String) {
        textSubject.value = text
    }
    
    public func websocketDidReceiveData(socket: Starscream.WebSocket, data: Data) {
        
    }
}
