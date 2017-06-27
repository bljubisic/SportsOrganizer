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
    var textSubject: Observable<CommMessage>! { get }
    var modelState: Variable<State> { get }
    
    func send(message: Message) -> Void
    func sendRegistration(message: RegMessage) -> Void
    func create(message: Message) -> Bool
    func changeState(from state:State, to: State) -> Void
    func collectAddressBookInfoWith(completion: ([AddressBook]) -> Bool) -> Void
}
