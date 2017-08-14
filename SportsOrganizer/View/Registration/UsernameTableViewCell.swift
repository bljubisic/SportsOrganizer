//
//  UsernameTableViewCell.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 7/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class UsernameTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var usernameTextField: UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        usernameTextField = UITextField()
        contentView.addSubview(usernameTextField)

        usernameTextField.snp.makeConstraints { (make) in
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
