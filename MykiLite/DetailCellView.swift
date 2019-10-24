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
    var fieldType: Fields?
    var isEditable: Bool = false
    var value: String?
    
    var copyBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.mykiGreen, for: .normal)
        button.setTitle("COPY", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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
    detailTextField.isEnabled = !isEditable

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
      titleLabel.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -60),
      titleLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 10),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),

      detailTextField.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 10),
      detailTextField.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -60),
      detailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      detailTextField.heightAnchor.constraint(equalToConstant: 18),
      ])
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
  }

    func getFieldText() -> (String, String) {
        guard let fieldType = fieldType else {return ("", "") }
        return (fieldType.getKey(), detailTextField.text ?? "")
    }
    
    @objc func copyText() {
        UIPasteboard.general.string = value
        copyBtn.setTitle("COPIED", for: .normal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.copyBtn.setTitle("COPY", for: .normal)
        }
    }
    
    func setupEditMode() {
        if isEditable {
            setupCopyForPassUser()
            setupLongPress()
        }
    }
    
    func setupCopyForPassUser() {
        guard let type = fieldType else {return}
        if type == .userName || type == .password {
        infoBackgroundView.addSubview(copyBtn)
            copyBtn.rightAnchor(to: infoBackgroundView.rightAnchor, constant: -20)
            copyBtn.centerYAnchor(to: infoBackgroundView.centerYAnchor)
            infoBackgroundView.bringSubviewToFront(copyBtn)
            copyBtn.addTarget(self, action: #selector(copyText), for: .touchUpInside)
        }
    }
    
    func setupLongPress() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(revealItem))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func revealItem() {
        self.detailTextField.text = value
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.detailTextField.text = "Hold to reveal item"
        }
    }
 
}
