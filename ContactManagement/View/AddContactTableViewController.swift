//
//  AddContactTableViewController.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController, ContactDelegate {
    
    var viewModel:AddContactViewModel?
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        if self.firstNameTextField.text == "" {
            self.onFailure(message: "First name field is empty")
        } else  if self.lastNameTextField.text == "" {
            self.onFailure(message: "Last name field is empty")
        }else  if !(self.viewModel?.isValidEmail(email: self.emailTextField.text))! {
            self.onFailure(message: "Invalid Email")
        }else if !(self.viewModel?.isValidMobileNumber(mobileNumber: self.mobileTextField.text))! {
            self.onFailure(message: "Invalid Mobile Number")
        }else{
            
            guard (self.viewModel?.getContact()) != nil else {
                self.viewModel?.addNewContactToServer(fname: self.firstNameTextField.text!, lname: self.lastNameTextField.text!, mobile: self.mobileTextField.text!, email: self.emailTextField.text!)
                return
            }
            self.viewModel?.updateContactToServer(fname: self.firstNameTextField.text!, lname: self.lastNameTextField.text!, mobile: self.mobileTextField.text!, email: self.emailTextField.text!)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()

        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, Constants.Color.themeColor.cgColor]
        self.gradientView.layer.insertSublayer(gradient, at: 0)
        guard (self.viewModel?.getContact()) != nil else {
            return
        }
        self.configureViews()
    }
    
    private func configureViews(){
        
        self.configureFirstNameLabel()
        self.configureLastNameLabel()
        self.configureEmailLabel()
        self.configureMobileNumberLabel()
        
        
        
    }
    
    private func configureMobileNumberLabel(){
        guard let mobile = self.viewModel?.getMobileNumber() else {
            return;
        }
        self.mobileTextField.text = mobile
    }
    
    private func configureEmailLabel(){
        guard let email = self.viewModel?.getEmail() else {
            return;
        }
        self.emailTextField.text = email
    }
    
    private func configureFirstNameLabel(){
        guard let name = self.viewModel?.getFirstName() else {
            return;
        }
        self.firstNameTextField.text = name
        
    }
    
    private func configureLastNameLabel(){
        guard let name = self.viewModel?.getLastName() else {
            return;
        }
        self.lastNameTextField.text = name
        
    }
    
    func getAlertText() -> String{
    guard (self.viewModel?.getContact()) != nil else {
        return "Successfully created the contact"
    
    }
        return "Successfully updated the contact"
    }
    
    // MARK: - Contact Delegates
    
    func onSuccess() {
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        let alert = UIAlertController(title: "", message: getAlertText(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
           self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onFailure(message: String) {
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


    
}
