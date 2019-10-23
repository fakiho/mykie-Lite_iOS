//
//  HeaderEditView.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/24/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

class HeaderEditView: UIView {
    var itemBackgroundView = UIView()
    var itemImageView = UIImageView()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    var emailLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    func commonInit() {
        self.backgroundColor = UIColor.clear

        itemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        itemBackgroundView.backgroundColor = .darkGray
        itemBackgroundView.layer.borderWidth = 1
        itemBackgroundView.layer.borderColor = UIColor.darkGray.cgColor
        itemBackgroundView.layer.cornerRadius = 5

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.layer.masksToBounds = true
        itemImageView.layer.borderWidth = 1
        itemImageView.layer.borderColor = UIColor.clear.cgColor
        itemImageView.image = UIImage(named: "default")

        self.addSubview(itemBackgroundView)
        itemBackgroundView.addSubview(titleLabel)
        itemBackgroundView.addSubview(emailLabel)
        itemBackgroundView.addSubview(itemImageView)
        
    }
    
    func addConstraint() {
        let constraints: [NSLayoutConstraint] = [
        itemBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        itemBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
        itemBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        itemBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        itemImageView.widthAnchor.constraint(equalTo: itemBackgroundView.heightAnchor, multiplier: 1 / 2.5),
        itemImageView.heightAnchor.constraint(equalTo: itemBackgroundView.heightAnchor, multiplier: 1 / 2.5),
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        itemImageView.centerYAnchor(to: centerYAnchor)
        itemImageView.leftAnchor(to: itemBackgroundView.leftAnchor, constant: 10)
        
        titleLabel.leftAnchor(to: itemImageView.rightAnchor, constant: 10)
        titleLabel.topAnchor(to: itemImageView.topAnchor)
        emailLabel.leftAnchor(to: itemImageView.rightAnchor, constant: 10)
        emailLabel.bottomAnchor(to: itemImageView.bottomAnchor)
        
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
           addConstraint()
       }

       required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
           commonInit()
           addConstraint()
       }
       
       override func layoutSublayers(of layer: CALayer) {
           super.layoutSublayers(of: layer)
           itemImageView.layer.cornerRadius = itemBackgroundView.frame.height / 5
       }
}
