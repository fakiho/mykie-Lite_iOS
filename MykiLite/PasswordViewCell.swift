//
//  PasswordViewCell.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class PasswordViewCell: UITableViewCell {

    internal lazy var passwordView: PasswordView = {
        let passwordView = PasswordView(frame: CGRect.zero)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordView)
        passwordView.setFillingConstraints(in: self)
        return passwordView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(title: String, subtitle: String, image: UIImage?) {
        self.passwordView.setup(title: title, subtitle: subtitle, image: image)
    }

}
