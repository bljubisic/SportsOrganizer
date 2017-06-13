//
//  SOModelProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 3/30/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SOModelProtocol {
    var textSubject: Observable<CommMessage>! { get }
    
    func send(message: Message) -> Void
    func create(message: Message) -> Bool
}
