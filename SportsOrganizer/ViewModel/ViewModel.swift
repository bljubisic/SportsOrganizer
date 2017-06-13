//
//  File.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 4/5/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

public class ViewModel: InitViewModelProtocol, InitViewModelInputs, InitViewModelOutputs {
    
    var model: SOModelProtocol
    var textVariable: Observable<CommMessage>

    var outputs: InitViewModelOutputs {
        return self
    }
    
    var inputs: InitViewModelInputs {
        return self
    }
    
    init(withModel model: SOModelProtocol) {
        self.model = model
        self.textVariable = model.textSubject
    }
    
    func send(message: Message) {
        model.send(message: message)
    }
}
