//
//  RegViewModelProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/21/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol RegViewModelOutputs {
    var appState: Observable<CommMessage> { get }
}

protocol RegViewModelInputs {
    func createRegMessage() -> RegMessage
    func sendRegistration(Message message: RegMessage) -> Bool
}

protocol RegViewModelProtocol {
    var firstname: String {get set}
    var lastname: String {get set}
    var username: String {get set}
    var phoneNumber: String {get set}
    
    var model: SOModelProtocol { get }
    var outputs: RegViewModelOutputs {get}
    var inputs: RegViewModelInputs { get }
}
