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
    func save(firstName name: String) -> Bool
    func save(lastName name: String) -> Bool
    func save(userName name: String) -> Bool
    func save(sport: String) -> Bool
    func save(birthDay date: Date) -> Bool
    func save(country: String) -> Bool
    func save(phoneNumber phone: String) -> Bool
    func sendRegistration(Message message: RegMessage) -> Bool
}

protocol RegViewModelInputs {
    var regResponse: Observable<CommMessage> { get }
}

protocol RegViewModelProtocol {
    var model: SOModelProtocol { get }
    var outputs: RegViewModelOutputs { get }
    var inputs: RegViewModelInputs { get }
}
