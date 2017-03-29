//
//  ContactDetailModel.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
import AFNetworking

class ContactDetailModel:NSObject{
    
    private var contact:Contact?
    var delegate:ContactDelegate?

    public init(delegate:ContactDelegate, contact:Contact) {
        super.init()
        self.delegate = delegate
        self.contact = contact
        if self.contact?.mobileNumber == nil || self.contact?.email == nil{
            self.getContactDetailsFromServer()
        }else{
            self.delegate?.onSuccess()
        }
    }
    
    func getMobileNumber() -> String?{
        return self.contact!.mobileNumber
    }
    
    func getEmail() -> String?{
        return self.contact!.email
    }
    
    func getID() -> Int64?{
        return self.contact!.contactId
    }
    
    func getIsFavourite() -> Bool?{
        return self.contact!.isFavourite
    }
    
    func getName() -> String?{
        return "\(self.contact!.firstName!) \(self.contact!.lastName!)"
    }
    
    func getContact() -> Contact {
        return self.contact!
    }
        
    private func getContactDetailsFromServer(){
        let manager = AFHTTPSessionManager()
        manager.get(self.contact!.contactUrl!,parameters: nil,
                    success:
            {(operation, responseObject) in
                print(responseObject as! NSDictionary)
                self.saveContactDataToDB(contactData: responseObject as! NSDictionary)
                DispatchQueue.main.async {
                    self.delegate?.onSuccess()
                }
        },
                    failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
                self.delegate?.onFailure(message: "Not able to connect to Server")
        })
    }
    
    private func saveContactDataToDB(contactData:NSDictionary){
        ContactsAdapter.contactAdapterSharedInstance.saveContactDataById(id: contactData.value(forKey: "id") as! Int, mobile: contactData.value(forKey: "phone_number") as! String, email: contactData.value(forKey: "email") as! String)
        self.contact?.mobileNumber = contactData.value(forKey: "phone_number") as! String
        self.contact?.email = contactData.value(forKey: "email") as! String

        
    }
    
    func saveContactIsFavouriteToDB(isFavourite:Bool){
        ContactsAdapter.contactAdapterSharedInstance.saveContactIsFavouriteById(id: Int(self.contact!.contactId), isFavourite: isFavourite)
        self.contact?.isFavourite = isFavourite
        
        
    }
    
    func deleteContact(){
        ContactsAdapter.contactAdapterSharedInstance.deleteContactById(id: self.contact!.contactId)
    }
    
    
    
    


}
