//
//  EnterTokenViewController.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 9/19/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class EnterTokenViewController: UIViewController {
    
    var token: UITextField!
    var viewModel: TokenViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendToken = UIBarButtonItem()
        sendToken.title = "Add"
        sendToken.action = #selector(createAndSendToken)
        
        self.navigationItem.title = "Registration"
        self.navigationItem.rightBarButtonItem = sendToken
        
        token = UITextField()
        token.placeholder = "Token"
        token.font = UIFont.systemFont(ofSize: 15)
        token.borderStyle = UITextBorderStyle.roundedRect
        token.autocorrectionType = UITextAutocorrectionType.no
        token.keyboardType = UIKeyboardType.default
        token.returnKeyType = UIReturnKeyType.done
        self.view.addSubview(token)
        token.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(self.view.snp.center)
        }
        
        self.token.rx.text.subscribe(
            onNext: { token in
                if let tokenUnwrapped = token {
                    self.viewModel.token = tokenUnwrapped
                }
        }).addDisposableTo(disposeBag)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAndSendToken() {
        let _ = self.viewModel.inputs.sendToken(Message: self.viewModel.inputs.createTokenMessage())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
