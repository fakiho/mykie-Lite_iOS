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
    var isEditable: Bool = false
    lazy var headerSaveView: HeaderSaveView = {
        let headerView = HeaderSaveView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy var headerEditView: HeaderEditView = {
        let headerView = HeaderEditView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupContent(source: String, client: inout CompanyLogoClient?, password: Password?) {
            client?.getLogo(domain: source, completion: { (image, error) in
                if(self.isEditable) {
                    DispatchQueue.main.async {
                        self.headerEditView.itemImageView.image = image
                        self.headerEditView.itemBackgroundView.backgroundColor = image?.averageColor
                        self.headerEditView.titleLabel.text = password?.nickname
                        self.headerEditView.emailLabel.text = password?.username
                    }
                } else {
                    DispatchQueue.main.async {
                        self.headerSaveView.itemImageView.image = image
                        self.headerSaveView.itemBackgroundView.backgroundColor = image?.averageColor
                    }
                }
            })
        }

    
    func setupViews(isEditable: Bool) {
        self.isEditable = isEditable
        if isEditable {
            self.contentView.addSubview(headerEditView)
            headerEditView.setFillingConstraints(in: self.contentView)
        }
        else {
            self.contentView.addSubview(headerSaveView)
            headerSaveView.setFillingConstraints(in: self.contentView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if isEditable {
            self.headerEditView.itemImageView.image = nil
            self.headerEditView.itemBackgroundView.backgroundColor = .darkGray
            self.headerEditView.titleLabel.text = nil
            self.headerEditView.emailLabel.text = nil
        }
        else {
            self.headerSaveView.itemImageView.image = nil
            self.headerSaveView.itemBackgroundView.backgroundColor = .grayG
        }
    }
 
}
