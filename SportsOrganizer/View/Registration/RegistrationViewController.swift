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
        
        self.cells = [self.tableView.dequeueReusableCell(withIdentifier: "firstname")!]
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
            observable.subscribe(onNext: {(string: String?) in
                print(string!)
            },
                                 onCompleted: {
                                    
                                    
            }).addDisposableTo(disposeBag)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Each cell will have same height except the ones with date pickers
        
        return 100.0
    }
}
