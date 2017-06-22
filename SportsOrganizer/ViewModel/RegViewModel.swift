//
//  RegViewModel.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/22/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

class RegViewModel: RegViewModelProtocol {
    var model: SOModelProtocol
    
    var regResponse: Observable<CommMessage>
    
    func sendRegistration(Message message: RegMessage) {
        model.sendRegistration(message: message)
    }
    
    init(withModel model: SOModelProtocol) {
        self.model = model
        self.regResponse = model.textSubject
    }
}
