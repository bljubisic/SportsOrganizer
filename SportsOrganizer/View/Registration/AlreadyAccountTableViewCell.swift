//
//  AlreadyAccountTableViewCell.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 7/30/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class AlreadyAccountTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var alreadyHaveAccountLabel: UILabel!
    var alreadyHaveAccountSwitch: UISwitch!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        alreadyHaveAccountLabel = UILabel()
        alreadyHaveAccountLabel.text = "Already exists?"
        contentView.addSubview(alreadyHaveAccountLabel)
        
        alreadyHaveAccountLabel.snp.makeConstraints { (make) in
            make.width.equalTo(115)
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).inset(0)
        }
        alreadyHaveAccountSwitch = UISwitch()
        alreadyHaveAccountSwitch.isOn = false
        contentView.addSubview(alreadyHaveAccountSwitch)
        
        alreadyHaveAccountSwitch.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
