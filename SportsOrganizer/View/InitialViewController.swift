//
//  InitialViewController.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/3/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class InitialViewController: UIViewController {

    var startButton: UIButton!
    
    var viewModel: InitViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        self.startButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 20.0))
        self.startButton.setTitle("Start", for: UIControlState.normal)
        
        self.view.addSubview(self.startButton)
        
        self.startButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        self.startButton.isEnabled = false
        self.startButton.addTarget(self, action: #selector(startEvent), for: .touchUpInside)
        
        _ = self.viewModel.outputs.textVariable.asObservable().map { (result: CommMessage) -> Data in
            if(result.state == .initialState) {
                self.startButton.isEnabled = true
            }
            return result.message
            }.subscribe(onNext: { result in
                print("Result: \(result)")
            }, onError: { (Error) in
                print("error")
            }, onCompleted: {
                print("completed")
            }) {
                print("Something")
        }
    }
    
    func startEvent() {
        print("START")
    }

}
