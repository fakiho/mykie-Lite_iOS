//
//  DetailCellView.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

class DetailCellView: UITableViewCell {

  var infoBackgroundView = UIView()
  var titleLabel = UILabel()
  var detailTextField = UITextField()
  var fieldType: Fields = .nickName

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.backgroundColor = UIColor.clear
    infoBackgroundView.layer.masksToBounds = true
    infoBackgroundView.layer.borderWidth = 1
    infoBackgroundView.layer.borderColor = UIColor.clear.cgColor

    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.textColor = .grayG
    titleLabel.font = UIFont.boldSystemFont(ofSize: 16)

    detailTextField.adjustsFontSizeToFitWidth = true
    detailTextField.textColor = .white
    detailTextField.font = UIFont.systemFont(ofSize: 16)
    detailTextField.autocorrectionType = .no

    self.contentView.addSubview(infoBackgroundView)
    infoBackgroundView.addSubview(titleLabel)
    infoBackgroundView.addSubview(detailTextField)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    infoBackgroundView.layer.cornerRadius = 3.0
    infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    detailTextField.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      infoBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
      infoBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
      infoBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      infoBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      titleLabel.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 10),
      titleLabel.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -10),
      titleLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 10),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),

      detailTextField.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 10),
      detailTextField.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -10),
      detailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      detailTextField.heightAnchor.constraint(equalToConstant: 18),
      ])
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
  }

    func getFieldText() -> (String, String) {
        return (fieldType.getKey(), detailTextField.text ?? "")
    }
}
