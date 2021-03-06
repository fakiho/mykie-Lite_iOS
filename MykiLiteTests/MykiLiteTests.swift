//
//  MykiLiteTests.swift
//  MykiLiteTests
//
//  Created by Awwad on 8/16/19.
//  Copyright © 2019 myki. All rights reserved.
//

import XCTest
@testable import MykiLite

class MykiLiteTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddPasswordWithEmptyData() {
        let oldPasswords = database.fetch(with: Password.all)
        
        let viewModel = AddPasswordViewModel(delegate: nil)
        viewModel.updatePassword()
        
        let newPasswords = database.fetch(with: Password.all)
        
        XCTAssertFalse(newPasswords.count == (oldPasswords.count + 1))
    }
    
    func testAddPassword() {
        
        let oldPasswords = database.fetch(with: Password.all)
        
        var viewModel = AddPasswordViewModel(delegate: nil)
        self.addMocPassword(with: &viewModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let newPasswords = database.fetch(with: Password.all)
            XCTAssertTrue(newPasswords.count == (oldPasswords.count + 1))
        }
        
    }
    
    func addMocPassword(with viewModel: inout AddPasswordViewModel) {
        
        viewModel.fieldNickname.text = "GMAIL"
        viewModel.fieldUsername.text = "test@gmail.com"
        viewModel.fieldPassword.text = "P@ssw0rd"
        viewModel.fieldWebsite.text  = "gmail.com"
        
        viewModel.savePassword()
    }
    
    func testDeletePasswordEmptyPassword() {
        
        let oldPasswords = database.fetch(with: Password.all)
        
        let viewModel = EditPasswordViewModel(delegate: nil)
        viewModel.deletePassword()
        
        let newPasswords = database.fetch(with: Password.all)
        
        XCTAssertFalse(newPasswords.count == (oldPasswords.count - 1))
        
    }
    
    func testDeletePassword() {
        
        let oldPasswords = database.fetch(with: Password.all)
        
        var viewModel = AddPasswordViewModel(delegate: nil)
        self.addMocPassword(with: &viewModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            let newPasswords = database.fetch(with: Password.all)
            
            XCTAssertTrue(newPasswords.count == (oldPasswords.count + 1))
            
            let editPasswordVC = EditPasswordViewModel(delegate: nil)
            editPasswordVC.password = viewModel.password
            
            editPasswordVC.deletePassword()
            
            let newDeletedPasswords = database.fetch(with: Password.all)
            
            XCTAssertFalse(newDeletedPasswords.count == (newPasswords.count - 1))
            
        }
        
    }
    
    func testLeakPassword() {
        let password = "P@ssw0rd"
        
        let viewModel = AddPasswordViewModel(delegate: nil)
        viewModel.checkIfPasswordLeaked(password: password) { (shouldSave, isLeaked) in
            XCTAssertTrue(isLeaked)
        }
        
    }
    
    func testUnleakedPassword() {
        
        let password = "@23Pfdeaidadabhflmgrifwn"
        
        let viewModel = AddPasswordViewModel(delegate: nil)
        viewModel.checkIfPasswordLeaked(password: password) { (shouldSave, isLeaked) in
            XCTAssertFalse(isLeaked)
        }
        
    }
    
}
