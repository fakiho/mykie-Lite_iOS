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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddPasswordViewModel()
        configureNavBar()
        configureView()
    }

  func configureNavBar() {
    self.title = "Add Password"
    self.navigationItem.largeTitleDisplayMode = .never
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePassword))
  }

  func configureView() {
    self.view.backgroundColor = .black
    self.tableView.separatorStyle = .none
    self.tableView.register(PasswordHeaderCellView.self, forCellReuseIdentifier: "headerCell")
    self.tableView.register(DetailCellView.self, forCellReuseIdentifier: "detailCell")
  }

  @objc func savePassword() {    
    viewModel.password = getAllFieldValues()
    guard let password = viewModel.password else {return}
    database.createOrUpdate(model: password, with: PasswordObject.init)
    self.navigationController?.popViewController(animated: true)
  }
    
    func getAllFieldValues() -> Password {
        var dict: [String:String] = [:]
        for field in viewModel.fields where field.title != .header {
            print(field.title.getKey())
            dict[field.title.getKey()] = field.value
        }
        dict["uuid"] = UUID().uuidString.lowercased()
        
        return Password(object: PasswordObject(password: Password(object: dict as NSDictionary)))
    }
    
    func fillData() {
        
    }

  @objc func textFieldChanged(_ textField: UITextField) {
    if let text = textField.text {
      viewModel.fields[textField.tag].value = text
    }
  }

}
