//
//  ContactDetailViewController.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class ContactDetailViewController: UITableViewController,ContactDelegate {

    var viewModel:ContactDetailViewModel?
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addContactVC") as! AddContactTableViewController
        controller.viewModel = AddContactViewModel(delegate:controller, contact: (self.viewModel?.getContact())!, maxId:1)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func messageButtonClicked(_ sender: UIButton) {
        self.viewModel?.sendMessage(viewController: self)
    }
    
    @IBAction func callButtonClicked(_ sender: UIButton) {
        self.viewModel?.makeCall(viewController:self)
    }
    
    @IBAction func emailButtonClicked(_ sender: UIButton) {
        self.viewModel?.sendEmail(viewController: self)
    }
    
    @IBAction func favouriteButtonClicked(_ sender: UIButton) {
        self.favouriteButton.isSelected = !self.favouriteButton.isSelected
        if self.favouriteButton.isSelected {
            self.favouriteButton.setImage( UIImage(named: "StarSelected"), for: UIControlState.normal)
        } else {
            self.favouriteButton.setImage( UIImage(named: "StarUnselected"), for: UIControlState.normal)
        }
        self.viewModel?.saveContactIsFavouriteToDB(isFavourite: self.favouriteButton.isSelected)

    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        let alert = UIAlertController(title: "Delete Contact", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
            self.viewModel?.deleteContact()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.tableView.tableFooterView = UIView()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, Constants.Color.themeColor.cgColor]
        self.gradientView.layer.insertSublayer(gradient, at: 0)

        // Do any additional setup after loading the view.
    }

    // MARK: - Configure methods

    private func configureViews(){
        
        self.configureNameLabel()
        self.configureEmailLabel()
        self.configureMobileNumberLabel()
        self.configureFavouriteButton()
       

       
    }
    
    private func configureMobileNumberLabel(){
        guard let mobile = self.viewModel?.getMobileNumber() else {
            return;
        }
        self.mobileNumberLabel.text = mobile
    }
    
    private func configureEmailLabel(){
        guard let email = self.viewModel?.getEmail() else {
            return;
        }
        self.emailLabel.text = email
    }
    
    private func configureNameLabel(){
        guard let name = self.viewModel?.getName() else {
            return;
        }
        self.nameLabel.text = name

    }
    
    private func configureFavouriteButton(){
        guard let isFavourite = self.viewModel?.getIsFavourite() else {
            return;
        }
        if isFavourite {
            self.favouriteButtonClicked(self.favouriteButton)
        }
    }
    
    // MARK: - Contact Delegates

    func onSuccess() {
        self.configureEmailLabel()
        self.configureMobileNumberLabel()
    }
    
    func onFailure(message: String) {
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
