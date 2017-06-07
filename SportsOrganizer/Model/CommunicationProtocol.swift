//
//  CommunicationProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/7/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

enum CommunicationStatus {
    case connected
    case disconnected
    case failed
}


protocol CommunicationProtocol {
    
    func connect()
    func send(Message message: Message) -> Bool
    func status() -> CommunicationStatus
    
}