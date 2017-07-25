//
//  ViewModelProtocol.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 4/5/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelProtocol {
    var model: SOModelProtocol { get }
}

protocol InitViewModelOutputs {
    var textVariable: Observable<CommMessage> { set get }
}

protocol InitViewModelInputs {
    func send(message: CommMessage)
}

protocol InitViewModelProtocol: ViewModelProtocol {
    var outputs: InitViewModelOutputs { get }
    var inputs: InitViewModelInputs { get }
}
