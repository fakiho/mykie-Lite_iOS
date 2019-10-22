//
//  PasswordView.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

class PasswordView: UIView {
    internal let cardAspectRation: CGFloat = 0.63
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let width: CGFloat = 100
        let height: CGFloat = 100
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = width / 2
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor(to: height)
        imageView.widthAnchor(to: width)
        imageView.leadingAnchor(to: leadingAnchor, constant: 16)
        imageView.centerYAnchor(to: centerYAnchor)
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor(to: imageView.trailingAnchor, constant: 16)
        label.trailingAnchor(to: self.trailingAnchor, constant: 0)
        label.topAnchor(to: imageView.topAnchor)
        label.bottomAnchor(to: imageView.centerYAnchor)
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor(to: imageView.trailingAnchor, constant: 16)
        label.trailingAnchor(to: trailingAnchor)
        label.topAnchor(to: imageView.centerYAnchor)
        label.bottomAnchor(to: imageView.bottomAnchor)
        return label
    }()
    
    func setup(title: String, subtitle: String, image: UIImage?) {
        self.titleLabel.text = title
        self.subtitle.text = subtitle
        self.imageView.image = image
    }
}
