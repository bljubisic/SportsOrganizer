//
//  SOModelProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 3/30/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SOModelProtocol {
    var textSubject: Variable<CommMessage> { get }
    var state: State { get }
    
    func send(message: CommMessage) -> Void
    func sendRegistration(message: RegMessage) -> Void
    func sendToken(message: TokenMessage) -> Void
    func create(message: Message) -> Bool
    func changeState(from state:State, to: State) -> Void
    func collectAddressBookInfoWith(completion: ([AddressBook]) -> Bool) -> Void
}
