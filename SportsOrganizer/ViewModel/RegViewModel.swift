//
//  RegViewModel.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/22/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

final class RegViewModel: RegViewModelProtocol, RegViewModelInputs, RegViewModelOutputs {
    var textSubject: Observable<CommMessage>
    
    
    var outputs: RegViewModelOutputs {
        return self
    }
    
    var firstname: String = ""
    var lastname: String = ""
    var username: String = ""
    var phoneNumber: String = ""
    
    func createRegMessage() -> RegMessage {
        return RegMessage(firstname: self.firstname, lastname: self.lastname, username: self.username, phone: self.phoneNumber)
    }
    
    func sendRegistration(Message message: RegMessage) -> Bool {
        model.sendRegistration(message: message)
        return true
    }
    
    var model: SOModelProtocol
    
    var inputs: RegViewModelInputs {
        return self
    }
    
    init(withModel model: SOModelProtocol) {
        self.model = model
        self.textSubject = model.textSubject.asObservable()
    }
}
