//
//  RegistrationViewController.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 6/21/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RegistrationViewController: UIViewController {
    
    var tableView: UITableView!
    var viewModel: RegViewModelProtocol!
    var cells: [UITableViewCell]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView()
    
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(FirstNameTableViewCell.self, forCellReuseIdentifier: "firstname")
        self.tableView.register(LastNameTableViewCell.self, forCellReuseIdentifier: "lastname")
        self.tableView.register(UsernameTableViewCell.self, forCellReuseIdentifier: "username")
        self.tableView.register(PhoneNumberTableViewCell.self, forCellReuseIdentifier: "phonenumber")
        
        self.cells = [self.tableView.dequeueReusableCell(withIdentifier: "firstname")!, self.tableView.dequeueReusableCell(withIdentifier: "lastname")!, self.tableView.dequeueReusableCell(withIdentifier: "username")!, self.tableView.dequeueReusableCell(withIdentifier: "phonenumber")!]
        // Do any additional setup after loading the view.
    }

}

extension RegistrationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}

extension RegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cells[indexPath.row]
        let disposeBag: DisposeBag = DisposeBag()
        if(indexPath.row == 0) {
            let observable: Observable<String?> = (cell as! FirstNameTableViewCell).firstNameTextField.rx.text.asObservable()
            observable.subscribe(onNext: {(firstname: String?) in
                print(firstname!)
            },
                                 onCompleted: {
                                    
                                    
            }).addDisposableTo(disposeBag)
        }
        else if indexPath.row == 1 {
            let lastNameObservable: Observable<String?> = (cell as! LastNameTableViewCell).lastNameTextField.rx.text.asObservable()
            lastNameObservable.subscribe(onNext: { (lastname: String?) in
                print(lastname!)
            }).addDisposableTo(disposeBag)
        }
        else if indexPath.row == 2 {
            let usernameObservable: Observable<String?> = (cell as! UsernameTableViewCell).usernameTextField.rx.text.asObservable()
            usernameObservable.subscribe(onNext: { (username: String?) in
                print(username!)
            }).addDisposableTo(disposeBag)
            
        }
        else if indexPath.row == 3 {
            let phoneNumberObservable: Observable<String?> = (cell as! PhoneNumberTableViewCell).phoneNumberTextField.rx.text.asObservable()
            phoneNumberObservable.subscribe(onNext: {(phonenumber: String?) in
                print(phonenumber!)
            }).addDisposableTo(disposeBag)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Each cell will have same height except the ones with date pickers
        
        return 100.0
    }
}
