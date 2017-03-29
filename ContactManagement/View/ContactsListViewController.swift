//
//  ViewController.swift
//  ContactManagement
//
//  Created by srinivasan on 25/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class ContactsListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,ContactDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBAction func addNewContactButtonClicked(_ sender: UIBarButtonItem) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addContactVC") as! AddContactTableViewController
        var maxId = self.viewModel?.getMaxId() == nil ? 1: self.viewModel?.getMaxId()
        controller.viewModel = AddContactViewModel(delegate:controller, contact: nil, maxId:maxId!)
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    var viewModel:ContactsListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ContactsListViewModel(delegate:self)
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadTableWithLocalData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        fixTableViewInsets()
    }

    // MARK: - Tableview delegates and data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.viewModel!.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCellForRowAtIndexPath(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact:Contact = self.viewModel!.getContactAtIndex(index:indexPath.row)
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contactDetailVC") as! ContactDetailViewController
        controller.viewModel = ContactDetailViewModel(delegate:controller, contact: contact)
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
      // MARK: - Contact delegates

    func onSuccess() {
        self.tableview.reloadData()
    }

    func onFailure(message: String) {
        self.showAlertWithOneButtonAndNoAction(title: "", message: message, buttonTitle: "OK")
    }
    
  
    // MARK: - Other methods

    private func getCellForRowAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableview.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        let contact:Contact = self.viewModel!.getContactAtIndex(index:indexPath.row)
        cell.nameLabel.text = "\(contact.firstName!) \(contact.lastName!)"
        cell.favouriteImage.isHidden = !contact.isFavourite
        cell.selectionStyle = .none;
        return cell
    }
    
    
    func reloadTableWithLocalData(){
        self.viewModel?.reloadTableWithLocalData()
        
    }
    
    
    func fixTableViewInsets() {
        let zContentInsets = UIEdgeInsets.zero
        self.tableview.contentInset = zContentInsets
        self.tableview.scrollIndicatorInsets = zContentInsets
    }
    
    


}

