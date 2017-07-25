//
//  RegViewModel.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/22/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

class RegViewModel: RegViewModelProtocol, RegViewModelInputs, RegViewModelOutputs {
    func save(firstName name: String) -> Bool {
        return true
    }
    
    func save(lastName name: String) -> Bool {
        return true
    }
    
    func save(userName name: String) -> Bool {
        return true
    }
    
    func save(sport: String) -> Bool {
        return true
    }
    
    func save(birthDay date: Date) -> Bool {
        return true
    }
    
    func save(country: String) -> Bool {
        return true
    }
    
    func save(phoneNumber phone: String) -> Bool {
        return true
    }
    
    func sendRegistration(Message message: RegMessage) -> Bool {
        model.sendRegistration(message: message)
        return true
    }
    
    var model: SOModelProtocol
    
    var regResponse: Observable<CommMessage>
    
    var inputs: RegViewModelInputs {
        return self
    }
    
    var outputs: RegViewModelOutputs {
        return self
    }
    
    init(withModel model: SOModelProtocol) {
        self.model = model
        self.regResponse = model.textSubject
    }
}
