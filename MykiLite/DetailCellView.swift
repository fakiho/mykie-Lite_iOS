//
//  DetailCellView.swift
//  MykiLite
//
//  Created by Awwad on 8/14/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

protocol DetailCellViewDelegate: class {
    func didPressCopyButton(in cell: DetailCellView)
}

class DetailCellView: UITableViewCell {
    
    weak var delegate: DetailCellViewDelegate?
    
    lazy var infoBackgroundView: UIView = {
        let _infoBackgroundView = UIView()
        _infoBackgroundView.layer.masksToBounds = true
        _infoBackgroundView.layer.borderWidth = 1
        _infoBackgroundView.layer.borderColor = UIColor.clear.cgColor
        _infoBackgroundView.backgroundColor = .darkGray
        _infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return _infoBackgroundView
    }()
    
    lazy var titleLabel: UILabel = {
        let _titleLabel = UILabel()
        _titleLabel.adjustsFontSizeToFitWidth = true
        _titleLabel.textColor = .grayG
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return _titleLabel
    }()
    
    lazy var detailTextField: UITextField = {
        let _detailTextField = UITextField()
        _detailTextField.adjustsFontSizeToFitWidth = true
        _detailTextField.textColor = .white
        _detailTextField.font = UIFont.systemFont(ofSize: 16)
        _detailTextField.autocorrectionType = .no
        _detailTextField.autocapitalizationType = .none
        _detailTextField.keyboardAppearance = .dark
        _detailTextField.tintColor = .mykiGreen
        _detailTextField.translatesAutoresizingMaskIntoConstraints = false
        return _detailTextField
    }()
    
    lazy var btnCopy: UIButton = {
        let _btnCopy = UIButton()
        _btnCopy.setTitle("COPY".localized, for: .normal)
        _btnCopy.setTitleColor(.mykiGreen, for: .normal)
        _btnCopy.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        _btnCopy.translatesAutoresizingMaskIntoConstraints = false
        _btnCopy.addTarget(self, action: #selector(didPressCopyBtn), for: .touchUpInside)
        return _btnCopy
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        clipsToBounds = true
        selectionStyle = .none
        
        self.contentView.addSubview(infoBackgroundView)
        infoBackgroundView.addSubview(titleLabel)
        infoBackgroundView.addSubview(detailTextField)
        infoBackgroundView.addSubview(btnCopy)
        
        infoBackgroundView.layer.cornerRadius = 3.0
        setupConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            infoBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            infoBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            infoBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            infoBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            btnCopy.rightAnchor.constraint(equalTo: infoBackgroundView.rightAnchor, constant: -10),
            btnCopy.centerYAnchor.constraint(equalTo: infoBackgroundView.centerYAnchor, constant: 0),
            btnCopy.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            btnCopy.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            
            detailTextField.leftAnchor.constraint(equalTo: infoBackgroundView.leftAnchor, constant: 10),
            detailTextField.rightAnchor.constraint(equalTo: btnCopy.leftAnchor, constant: -10),
            detailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            detailTextField.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    @objc func didPressCopyBtn() {
        self.delegate?.didPressCopyButton(in: self)
    }
    
}
