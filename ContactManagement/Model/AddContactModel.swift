//
//  AddContactModel.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
import AFNetworking

class AddContactModel:NSObject{
    
    private var contact:Contact?
    var delegate:ContactDelegate?
    var maxId:Int64?
    
    public init(delegate:ContactDelegate, contact:Contact?, maxId:Int64) {
        super.init()
        self.maxId = maxId
        self.delegate = delegate
        self.contact = contact
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
    
    func getFirstName() -> String?{
        return self.contact!.firstName
    }
    
    func getLastName() -> String?{
        return self.contact!.lastName
    }

    func getContact() -> Contact? {
        return self.contact
    }
    
    func addNewContactToServer(fname:String, lname:String, mobile:String, email:String){
        
        let manager = AFHTTPSessionManager()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateString = dateFormatter.string(from: Date())
        let url = "\(Constants.Url.baseURL)\(Constants.Url.postNewContact)"
        let parameters : [String:AnyObject] = ["id": 1 as AnyObject,
                                               "first_name": fname as AnyObject,
                                               "last_name": lname as AnyObject,
                                               "email": email as AnyObject,
                                               "phone_number": mobile as AnyObject,
                                               "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610" as AnyObject,
                                               "favorite": false as AnyObject,
                                               "created_at": dateString as AnyObject,
                                               "updated_at": dateString as AnyObject] as [String : AnyObject]
        
        let requestSerializer = AFJSONRequestSerializer()
        requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer = requestSerializer
        
        manager.post(url, parameters: parameters, progress: { (progress) in
            
        }, success: { (operation, response) in
            ContactsAdapter.contactAdapterSharedInstance.saveContact(id: <#T##Int#>, firstName: <#T##String#>, lastName: <#T##String#>, profilePic: <#T##String#>, url: <#T##String#>, isFavourite: <#T##Bool#>)
            self.delegate?.onSuccess()
        }) { (operation, error) in
            print(error.localizedDescription)
            self.delegate?.onFailure(message: "Could not connect to server. Please try again.")
        }
        
    }
    
    func updateContactToServer(fname:String, lname:String, mobile:String, email:String){
        
        let manager = AFHTTPSessionManager()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateString = dateFormatter.string(from: Date())
        let url = "\(Constants.Url.baseURL)\(Constants.Url.getContactDetailsForID(contactID: (self.contact?.contactId)!))"
        let parameters : [String:AnyObject] = ["id": self.contact?.contactId as AnyObject,
                                               "first_name": fname as AnyObject,
                                               "last_name": lname as AnyObject,
                                               "email": email as AnyObject,
                                               "phone_number": mobile as AnyObject,
                                               "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610" as AnyObject,
                                               "favorite": false as AnyObject,
                                               "created_at": dateString as AnyObject,
                                               "updated_at": dateString as AnyObject] as [String : AnyObject]
        
        let requestSerializer = AFJSONRequestSerializer()
        requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer = requestSerializer
        
        manager.put(url, parameters: parameters, success: { (operation, response) in
            ContactsAdapter.contactAdapterSharedInstance.saveContactDataById(id: Int((self.contact?.contactId)!), fname: fname, lname: lname, mobile: mobile, email: email)

            self.delegate?.onSuccess()
        }) { (operation, error) in
            print(error.localizedDescription)
            self.delegate?.onFailure(message: "Could not connect to server. Please try again.")
        }
        
    }

    
   
}
