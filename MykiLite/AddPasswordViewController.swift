//
//  AddPasswordViewController.swift
//  MykiLite
//
//  Created by Awwad on 8/13/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

class AddPasswordViewController: UITableViewController, UITextFieldDelegate {

    var viewModel: AddPasswordViewModel!
    var uuid: String? {
        didSet {
            isEditable = (uuid != nil)
        }
    }
    var isEditable: Bool = false
    internal var client: CompanyLogoClient?
    var tableFooterView: FooterEditView? = FooterEditView()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddPasswordViewModel()
        configureNavBar()
        configureView()
        client = CompanyLogoClient(dataProvider: GenericClientDataProvider())
        fillData()
        addFooterViewIfEditable()
       // NotificationCenter.default.removeObserver(self, name: , object: )
    }

  func configureNavBar() {
    self.navigationItem.largeTitleDisplayMode = .never
    if isEditable {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(saveOrEditPassword))
        self.title = "Edit Password"

    } else {
        self.title = "Add Password"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveOrEditPassword))
    }
  }

  func configureView() {
    self.view.backgroundColor = .black
    self.tableView.separatorStyle = .none
    self.tableView.register(PasswordHeaderCellView.self, forCellReuseIdentifier: "headerCell")
    self.tableView.register(DetailCellView.self, forCellReuseIdentifier: "detailCell")
  }

  @objc func saveOrEditPassword() {
    if isEditable {
        isEditable = false
        tableView.reloadData()
        configureNavBar()
    } else {
        guard let password = getAllFieldValues() else {
            return
        }
        viewModel.password = password
        database.createOrUpdate(model: password, with: PasswordObject.init)
        self.navigationController?.popViewController(animated: true)
    }
  }
    
    func getAllFieldValues() -> Password? {
        var dict: [String:String] = [:]
        for field in viewModel.fields where field.title != .header {
            if field.title == .nickName, field.value == "" {
                return nil
            }
            dict[field.title.getKey()] = field.value
        }
        if let uuid = viewModel.editablePassword?.uuid {
            dict["uuid"] = uuid
        } else {
            dict["uuid"] = UUID().uuidString.lowercased()
        }
        
        
        return Password(object: PasswordObject(password: Password(object: dict as NSDictionary)))
    }
    
    func getEditablePassword() {
        if isEditable {
            viewModel.getPasswordByUUID(for: uuid!)
        }
    }
    
    func fillData() {
        getEditablePassword()
    }

    @objc func textFieldChanged(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.fields[textField.tag].value = text
            
            if viewModel.fields[textField.tag].title == .nickName {
                viewModel.fields[Fields.password.rawValue].isEnabled = (text != "")
                tableView.reloadRows(at: [IndexPath(row: Fields.password.rawValue, section: 0)], with: .none)
            }
            
            if viewModel.fields[textField.tag].title == .website {
                tableView.reloadRows(at: [IndexPath(row: Fields.header.rawValue, section: 0)], with: .none)
            }
        }
    }
    
    func addFooterViewIfEditable() {
        if (isEditable) {
            tableFooterView?.translatesAutoresizingMaskIntoConstraints = false
            self.navigationController?.view.addSubview(tableFooterView!)
            tableFooterView?.bottomAnchor(to: self.navigationController!.view.bottomAnchor, constant: 0)
            tableFooterView?.leftAnchor(to: self.navigationController!.view.leftAnchor, constant: 0)
            tableFooterView?.rightAnchor(to: self.navigationController!.view.rightAnchor, constant: 0)
            tableFooterView?.heightAnchor(to: 70)
            tableFooterView?.action = {
                guard let uuid = self.uuid else {return}
                self.viewModel.delete(by: uuid)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if tableFooterView != nil {
            tableFooterView?.removeFromSuperview()
        }
    }
}
extension NSNotification.Name {
    public static let UserNameEdited: NSNotification.Name = Notification.Name("on-username-changed")
}
