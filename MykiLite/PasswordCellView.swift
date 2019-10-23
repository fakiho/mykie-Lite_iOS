//
//  PasswordCellView.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class PasswordCellView: UITableViewCell {

  var itemBackView = UIView()
  var nicknameLabel = UILabel()
  var emailLabel = UILabel()
  var itemImageView = UIImageView()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = UIColor.clear

    itemBackView.layer.masksToBounds = true
    itemBackView.layer.borderWidth = 1
    itemBackView.layer.borderColor = UIColor.clear.cgColor
    itemBackView.layer.cornerRadius = 3

    itemImageView.contentMode = .scaleAspectFit
    itemImageView.layer.masksToBounds = true
    itemImageView.layer.borderWidth = 1
    itemImageView.layer.borderColor = UIColor.clear.cgColor
    itemImageView.image = UIImage(named: "default")

    nicknameLabel.adjustsFontSizeToFitWidth = true
    nicknameLabel.textColor = .white
    nicknameLabel.font = UIFont.boldSystemFont(ofSize: 17)

    emailLabel.adjustsFontSizeToFitWidth = true
    emailLabel.textColor = .grayG
    emailLabel.font = UIFont.systemFont(ofSize: 13)

    self.contentView.addSubview(itemBackView)
    itemBackView.addSubview(itemImageView)
    itemBackView.addSubview(nicknameLabel)
    itemBackView.addSubview(emailLabel)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

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

    
    func setupContent(nickname: String, email: String, itemImage: UIImage?) {
        self.nicknameLabel.text = nickname
        self.emailLabel.text = email
        self.itemImageView.image = itemImage
    }
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    itemImageView.layer.cornerRadius = itemImageView.frame.height / 2
  }

}
