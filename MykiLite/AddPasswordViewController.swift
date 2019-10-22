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
  var uuid: String?
    
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
        for i in 1 ..<  viewModel.fields.count {
            let index = IndexPath(row: i, section: 0)
            let cell: DetailCellView = tableView.cellForRow(at: index) as! DetailCellView
            let (key,val) = cell.getFieldText()
            dict[key] = val
        }
        dict["uuid"] = UUID().uuidString.lowercased()
        
        return Password(object: PasswordObject(password: Password(object: dict as NSDictionary)))
    }

  @objc func textFieldChanged(_ textField: UITextField) {
    if let text = textField.text {
      viewModel.fields[textField.tag].value = text
    }
  }

}
