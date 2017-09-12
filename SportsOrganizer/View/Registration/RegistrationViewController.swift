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
    var firstNameCell: FirstNameTableViewCell = FirstNameTableViewCell()
    var lastNameCell: LastNameTableViewCell = LastNameTableViewCell()
    var usernameCell: UsernameTableViewCell = UsernameTableViewCell()
    var phoneNumberCell: PhoneNumberTableViewCell = PhoneNumberTableViewCell()
    var firstNameObservable: Observable<String?>!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendRegistration = UIBarButtonItem()
        sendRegistration.title = "Add"
        sendRegistration.action = #selector(createAndSendRegistration)
        
        self.navigationItem.title = "Registration"
        self.navigationItem.rightBarButtonItem = sendRegistration
        
        
        self.tableView = UITableView()
    
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(FirstNameTableViewCell.self, forCellReuseIdentifier: "firstname")
        self.tableView.register(LastNameTableViewCell.self, forCellReuseIdentifier: "lastname")
        self.tableView.register(UsernameTableViewCell.self, forCellReuseIdentifier: "username")
        self.tableView.register(PhoneNumberTableViewCell.self, forCellReuseIdentifier: "phonenumber")
        self.firstNameCell.firstNameTextField.rx.text.subscribe(
            onNext: {(firstname: String?) in
                guard let firstnameUnwrapped = firstname else {
                    return
                }
                self.viewModel.firstname = firstnameUnwrapped
            },
            onCompleted: {
                print("Done")
        }).addDisposableTo(self.disposeBag)
        self.lastNameCell.lastNameTextField.rx.text.subscribe(
            onNext: {lastname in
                guard let lastnameUnwrapped = lastname else {
                    return
                }
                self.viewModel.lastname = lastnameUnwrapped
            },
            onCompleted: {
                print("Done")
        }).addDisposableTo(self.disposeBag)
        self.usernameCell.usernameTextField.rx.text.subscribe(
            onNext: {username in
                guard let usernameUnwrapped = username else {
                    return
                }
                self.viewModel.username = usernameUnwrapped
            },
            onCompleted: {
                print("Done")
            }
        ).addDisposableTo(self.disposeBag)
        self.phoneNumberCell.phoneNumberTextField.rx.text.subscribe(
            onNext: {phoneNumber in
                guard let phoneNumberUnwrapped = phoneNumber else {
                    return
                }
                self.viewModel.phoneNumber = phoneNumberUnwrapped
            },
            onCompleted: {
                print("Done")
            }
        ).addDisposableTo(self.disposeBag)
        // Do any additional setup after loading the view.
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        self.tableView.reloadData()
    }
    
    func createAndSendRegistration() {
        let _ = self.viewModel.outputs.sendRegistration(Message: self.viewModel.outputs.createRegMessage())
    }

}

extension RegistrationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
}

extension RegistrationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("returned size: 6")
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            return self.firstNameCell
        }
        else if indexPath.row == 1 {
            return self.lastNameCell
        }
        else if indexPath.row == 2 {
            return self.usernameCell
            
        }
        else {
            return self.phoneNumberCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Each cell will have same height except the ones with date pickers
        
        return 100.0
    }
}
