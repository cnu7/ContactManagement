//
//  ContactsListModel.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
import AFNetworking

public protocol ContactDelegate: class {
    func onSuccess()
    func onFailure(message:String)
}

class ContactsListModel:NSObject{
    
    private var contactArray = [Contact]()
    var delegate:ContactDelegate?
    public init(delegate:ContactDelegate) {
        super.init()
        self.delegate = delegate;
        self.getContactsFromServer()
    }
    
    
    func getDataCount() -> Int{
        return self.contactArray.count
    }
    
    func getContactAtIndex(index:Int) -> Contact{
        return self.contactArray[index]
    }

    private func getContactsFromServer(){
        let manager = AFHTTPSessionManager()
        let url = "\(Constants.Url.baseURL)\(Constants.Url.getContactsList)"
        
        manager.get(url,parameters: nil,
                    success:
            {
                (operation, responseObject) in
                
                print(responseObject as! NSArray)
                self.saveContactsToDB(contactData: responseObject as! NSArray)
                DispatchQueue.main.async {
                    if (responseObject as! NSArray).count > 0{
                        self.fetchContactsFromCoreData()
                        self.delegate?.onSuccess()
                    }else{
                        self.delegate?.onFailure(message: "No contacts found")
                    }
                }
        },
                    failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
                self.delegate?.onFailure(message: "Not able to connect to Server")
        })
    }

    private func saveContactsToDB(contactData:NSArray){
        if contactData.count > 0{
            for contDict in contactData{
                ContactsAdapter.contactAdapterSharedInstance.saveContact(id: (contDict as! NSDictionary).value(forKey: "id") as! Int, firstName: (contDict as! NSDictionary).value(forKey: "first_name") as! String, lastName: (contDict as! NSDictionary).value(forKey: "last_name") as! String, profilePic: (contDict as! NSDictionary).value(forKey: "profile_pic") as! String, url: (contDict as! NSDictionary).value(forKey: "url") as! String,isFavourite:(contDict as! NSDictionary).value(forKey: "favorite") as! Bool)
            }
        }
    }
    
    private func fetchContactsFromCoreData(){
        if let contacts = ContactsAdapter.contactAdapterSharedInstance.getContacts(){
            self.contactArray = contacts.sorted { $0.firstName! < $1.firstName! }
            
        }
    }
    
    func reloadTableWithLocalData(){
        if self.contactArray.count > 0{
            self.fetchContactsFromCoreData()
            self.delegate?.onSuccess()
        }
    }
}
