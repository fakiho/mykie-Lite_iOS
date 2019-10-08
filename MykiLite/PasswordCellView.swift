//
//  PasswordCellView.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class PasswordCellView: UITableViewCell {
    
    lazy var itemBackView: UIView = {
        let _itemBackView = UIView()
        _itemBackView.layer.masksToBounds = true
        _itemBackView.layer.borderWidth = 1
        _itemBackView.layer.borderColor = UIColor.clear.cgColor
        _itemBackView.layer.cornerRadius = 3
        _itemBackView.backgroundColor = .navBar
        return _itemBackView
    }()
    
    lazy var nicknameLabel: UILabel = {
        let _nicknameLabel = UILabel()
        _nicknameLabel.adjustsFontSizeToFitWidth = true
        _nicknameLabel.textColor = .white
        _nicknameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return _nicknameLabel
    }()
    
    lazy var emailLabel: UILabel = {
        let _emailLabel = UILabel()
        _emailLabel.adjustsFontSizeToFitWidth = true
        _emailLabel.textColor = .grayG
        _emailLabel.font = UIFont.systemFont(ofSize: 13)
        return _emailLabel
    }()
    
    lazy var itemImageView: UIImageView = {
        let _itemImageView = UIImageView()
        _itemImageView.contentMode = .scaleAspectFit
        _itemImageView.layer.masksToBounds = true
        _itemImageView.layer.borderWidth = 1
        _itemImageView.layer.borderColor = UIColor.clear.cgColor
        _itemImageView.image = UIImage(named: "default")
        _itemImageView.clipsToBounds = true
        return _itemImageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(itemBackView)
        
        itemBackView.addSubview(itemImageView)
        itemBackView.addSubview(nicknameLabel)
        itemBackView.addSubview(emailLabel)
        
        selectionStyle = .none
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        
        itemBackView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemBackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            itemBackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            itemBackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemBackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            itemImageView.leftAnchor.constraint(equalTo: itemBackView.leftAnchor, constant: 10),
            itemImageView.topAnchor.constraint(equalTo: itemBackView.topAnchor, constant: 10),
            itemImageView.heightAnchor.constraint(equalTo: itemBackView.heightAnchor, constant: -20),
            itemImageView.widthAnchor.constraint(equalTo: itemBackView.heightAnchor, constant: -20),
            
            nicknameLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 8),
            nicknameLabel.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 10),
            nicknameLabel.heightAnchor.constraint(equalToConstant: 20),
            nicknameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            emailLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 8),
            emailLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 14),
            emailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }
    
    func setCell(with title: String, detail: String, img: String) {
        nicknameLabel.text = title
        emailLabel.text = detail
        itemImageView.loadImg(with: img, placeholder: UIImage(named: "default")) {
            [weak self] (error, image) in
            self?.itemImageView.clipsToBounds = true
            self?.itemImageView.layer.cornerRadius = (self?.itemImageView.frame.height ?? 0) / 2
        }
    }
    
}
