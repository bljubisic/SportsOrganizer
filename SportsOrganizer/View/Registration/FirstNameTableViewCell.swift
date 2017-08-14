//
//  FirstNameTableViewCell.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 7/20/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class FirstNameTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var firstNameTextField: UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        firstNameTextField = UITextField()
        contentView.addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).inset(-5.0)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(-5.5)
            make.leading.equalTo(self.contentView.snp.leading).inset(-8.0)
            make.trailing.equalTo(self.contentView.snp.trailing).inset(-8.0)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
