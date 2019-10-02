//
//  PasswordHeaderCellView.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

class PasswordHeaderCellView: UITableViewCell {
    
    lazy var itemBackgroundView: UIView = {
        let _itemBackgroundView = UIView()
        _itemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        _itemBackgroundView.backgroundColor = .darkGray
        _itemBackgroundView.layer.borderWidth = 1
        _itemBackgroundView.layer.borderColor = UIColor.darkGray.cgColor
        _itemBackgroundView.layer.cornerRadius = 5
        return _itemBackgroundView
    }()
    
    lazy var itemImageView: UIImageView = {
        let _itemImageView = UIImageView()
        _itemImageView.translatesAutoresizingMaskIntoConstraints = false
        _itemImageView.layer.masksToBounds = true
        _itemImageView.layer.borderWidth = 1
        _itemImageView.layer.borderColor = UIColor.clear.cgColor
        _itemImageView.image = UIImage(named: "default")
        return _itemImageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(itemBackgroundView)
        itemBackgroundView.addSubview(itemImageView)
        
        selectionStyle = .none
        clipsToBounds = true
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        itemImageView.layer.cornerRadius = itemBackgroundView.frame.height / 5
    }
    
    private func setupConstraints() {
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
    
    func setCell(with url: String) {
        itemImageView.loadImg(with: url, placeholder: UIImage(named: "default")) { (error, image) in
            
        }
    }
    
}
