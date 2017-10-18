//
//  File.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 4/5/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

final class ViewModel: InitViewModelProtocol, InitViewModelInputs, InitViewModelOutputs {
    
    var model: SOModelProtocol
    var appState: Observable<CommMessage>

    var outputs: InitViewModelOutputs {
        return self
    }
    
    var inputs: InitViewModelInputs {
        return self
    }
    
    init(withModel model: SOModelProtocol) {
        self.model = model
        self.appState = model.appStateAndMessage.asObservable()
    }
    
    func send(message: CommMessage) {
        model.send(message: message)
    }
}
