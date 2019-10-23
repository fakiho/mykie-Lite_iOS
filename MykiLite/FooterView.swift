//
//  FooterView.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/24/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

class FooterEditView: UIView {
    typealias callBack = (() -> Void)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        addSubview(buttonDelete)
        buttonDelete.leftAnchor(to: self.leftAnchor, constant: 16)
        buttonDelete.centerYAnchor(to: self.centerYAnchor, constant: -10)
        buttonDelete.heightAnchor(to: 25)
        buttonDelete.widthAnchor(to: 25)
        buttonDelete.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
    }
    var action: callBack?
    
    @objc func deleteAction(_ sender: Any) {
        self.action?()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var buttonDelete: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_trash"), for: .normal)
        button.tintColor = UIColor.mykiGreen
        return button
    }()
}
