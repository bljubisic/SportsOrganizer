//
//  File.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 4/5/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation

public class ViewModel: ViewModelProtocol {
    
    var message: Message
    var model: SOModelProtocol
    
    init(withModel model: SOModelProtocol) {
        self.model = model
        self.message = Message(message: "", timeStamp: Date())
    }
    
    func send(message: Message) {
        model.send(message: message)
    }
}
