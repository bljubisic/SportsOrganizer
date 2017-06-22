//
//  RegViewModelProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/21/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol RegViewModelProtocol {
    var model: SOModelProtocol { get }
    var regResponse: Observable<CommMessage> { get }
    
    func sendRegistration(Message message: RegMessage) -> Void
    
}
