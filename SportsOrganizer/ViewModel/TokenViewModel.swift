//
//  TokenViewModel.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 9/23/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift


final class TokenViewModel: TokenViewModelInputs, TokenViewModelOutputs, TokenViewModelProtocol {
    var phone🔢: String
    
    func createTokenMessage() -> TokenMessage {
        return TokenMessage(phone: phone🔢, token: token)
    }
    
    func sendToken(Message message: TokenMessage) -> Bool {
        model.sendToken(message: message)
        return true
    }
    
    var messageObservable: Observable<CommMessage>
    
    var token: String = ""
    var model: SOModelProtocol
    
    var outputs: TokenViewModelOutputs {
        return self
    }
    
    var inputs: TokenViewModelInputs {
        return self
    }
    
    init(withModel model: SOModelProtocol, andPhone phone: String) {
        self.model = model
        self.phone🔢 = phone
        self.messageObservable = model.appStateAndMessage.asObservable()
    }
    
}
