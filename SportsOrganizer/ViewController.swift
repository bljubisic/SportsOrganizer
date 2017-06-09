//
//  ViewController.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 3/29/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var titleLabel: UILabel!
    var messageTextField: UITextField!
    var sendButton: UIButton!
    var responseTextView: UITextView!
    var viewModel: InitViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 21))
        self.messageTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 348, height: 30))
        
        self.messageTextField.borderStyle = UITextBorderStyle.roundedRect
        self.messageTextField.font = UIFont.systemFont(ofSize: 15)
        self.messageTextField.placeholder = "enter text"
        self.messageTextField.autocorrectionType = UITextAutocorrectionType.no
        self.messageTextField.keyboardType = UIKeyboardType.default
        self.messageTextField.returnKeyType = UIReturnKeyType.done
        self.messageTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        self.messageTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        self.sendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 46, height: 30))
        
        self.sendButton.setTitle("Send", for: UIControlState.normal)
        self.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        self.responseTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 343, height: 128))
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.messageTextField)
        self.view.addSubview(self.sendButton)
        self.view.addSubview(self.responseTextView)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).inset(20)
            make.bottom.equalTo(self.messageTextField.snp.top).inset(-36)
            //make.height.equalTo(21)
            make.width.equalTo(130)
        }
        self.messageTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.titleLabel).inset(36)
            make.bottom.equalTo(self.sendButton.snp.top).inset(-8)
            //make.height.equalTo(30)
            make.width.equalTo(348)
        }
        self.sendButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.messageTextField.snp.bottom).inset(-8)
            make.bottom.equalTo(self.responseTextView.snp.top).inset(-20)
            //make.height.equalTo(30)
            make.width.equalTo(46)
        }
        self.responseTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.sendButton.snp.bottom).inset(-20)
            make.height.equalTo(128)
            make.width.equalTo(343)
        }
        //let disposeBag = DisposeBag()
        /*
        _ = self.viewModel.outputs.textVariable.asObservable().map { (result: String) -> String in
            return result
            }.subscribe(onNext: { (result: String) in
                print("Result: \(result)")
        }, onError: { (Error) in
            print("error")
        }, onCompleted: {
            print("completed")
        }) { 
            print("Something")
        }
        */
        //self.viewModel.outputs.textVariable.asObservable().bindTo(self.responseTextView.rx.text).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMessage() {
        let message = Message(message: self.messageTextField!.text!, timeStamp: Date())
        self.viewModel.inputs.send(message: message)
    }


}

