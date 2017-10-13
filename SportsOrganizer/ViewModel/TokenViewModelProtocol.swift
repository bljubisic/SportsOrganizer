//
//  TokenViewModelProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 9/23/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol TokenViewModelOutputs {
    var messageObservable: Observable<CommMessage> { get }
    var phone🔢: String { get }
}

protocol TokenViewModelInputs {
    func createTokenMessage() -> TokenMessage
    func sendToken(Message message: TokenMessage) -> Bool
}

protocol TokenViewModelProtocol {
    var token: String { set get }
    var model: SOModelProtocol { get }
    var outputs: TokenViewModelOutputs { get }
    var inputs: TokenViewModelInputs { get }
}
