//
//  PhoneNumberTableViewCell.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 7/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class PhoneNumberTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var phoneNumberTextField: UITextField!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        phoneNumberTextField = UITextField()
        phoneNumberTextField.placeholder = "Phone number"
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 15)
        phoneNumberTextField.borderStyle = UITextBorderStyle.roundedRect
        phoneNumberTextField.autocorrectionType = UITextAutocorrectionType.no
        phoneNumberTextField.keyboardType = UIKeyboardType.default
        phoneNumberTextField.returnKeyType = UIReturnKeyType.done
        contentView.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).inset(30.0)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(30.5)
            make.leading.equalTo(self.contentView.snp.leading).inset(10.0)
            make.trailing.equalTo(self.contentView.snp.trailing).inset(10.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
