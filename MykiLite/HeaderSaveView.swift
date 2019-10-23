//
//  HeaderEditableView.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/24/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit


class HeaderSaveView: UIView {
    
    var itemBackgroundView = UIView()
    var itemImageView = UIImageView()

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
        itemBackgroundView.addSubview(itemImageView)
    }
    
    func addConstraint() {
        let constraints: [NSLayoutConstraint] = [
             itemBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
             itemBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
             itemBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
             itemBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

             itemImageView.centerXAnchor.constraint(equalTo: itemBackgroundView.centerXAnchor),
             itemImageView.centerYAnchor.constraint(equalTo: itemBackgroundView.centerYAnchor),
             itemImageView.widthAnchor.constraint(equalTo: itemBackgroundView.heightAnchor, multiplier: 1 / 2.5),
             itemImageView.heightAnchor.constraint(equalTo: itemBackgroundView.heightAnchor, multiplier: 1 / 2.5),
           ]

           NSLayoutConstraint.activate(constraints)
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
