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

public class WebSocketCommunication: CommunicationProtocol {
    
    var socket: WebSocket
    
    init(withURL url: URL) {
        socket =  WebSocket(url)
    }
    
    
    
    
}

