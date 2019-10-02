//
//  AddPasswordViewController.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class AddPasswordViewController: UITableViewController, UITextFieldDelegate, CommonAlert {
    
    var viewModel: AddPasswordViewModel!
    lazy var btnEditSave: UIButton = {
        let _btnEditSave = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        _btnEditSave.setTitle("Save".localized, for: .normal)
        _btnEditSave.setTitle("Edit", for: .selected)
        _btnEditSave.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        _btnEditSave.setTitleColor(.mykiGreen, for: .normal)
        return _btnEditSave
    }()
    
    lazy var deleteFooterView: UIView = {
        
        let _deleteFooterView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.tableView.frame.size.width, height: 50))
        
        let btnDelete = UIButton()
        btnDelete.tintColor = .mykiGreen
        btnDelete.setImage(UIImage(named: "bin"), for: .normal)
        btnDelete.addTarget(self, action: #selector(didPressDeleteButton), for: .touchUpInside)
        _deleteFooterView.addSubview(btnDelete)
        
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnDelete.leftAnchor.constraint(equalTo: _deleteFooterView.leftAnchor, constant: 15),
            btnDelete.centerYAnchor.constraint(equalTo: _deleteFooterView.centerYAnchor, constant: 0),
            btnDelete.heightAnchor.constraint(equalToConstant: 25),
            btnDelete.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        return _deleteFooterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
    }
    
    func configureNavBar() {
        
        self.title = self.viewModel.title?.localized
        self.navigationItem.largeTitleDisplayMode = .never
        
        if self.viewModel.type == .edit {
            btnEditSave.isSelected = true
        }
        
        btnEditSave.addTarget(self, action: #selector(didPressNavButton), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnEditSave)
        
    }
    
    func configureView() {
        self.view.backgroundColor = .black
        self.tableView.separatorStyle = .none
        self.tableView.register(PasswordHeaderCellView.self, forCellReuseIdentifier: "headerCell")
        self.tableView.register(DetailCellView.self, forCellReuseIdentifier: "detailCell")
        
        if viewModel.type == .edit {
            self.tableView.tableFooterView = deleteFooterView
        }
    }
    
    @objc func didPressNavButton() {
        viewModel.didPressNavButton()
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.fields[textField.tag].value = text
        }
    }
    
    @objc func didPressDeleteButton() {
        guard let vModel = self.viewModel as? EditPasswordViewModel else { return }
        vModel.deletePassword()
    }
    
}
