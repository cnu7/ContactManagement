//
//  AddContactViewModel.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
class AddContactViewModel: NSObject, ContactDelegate {
    
    private var model:AddContactModel?
    var delegate:ContactDelegate?
    
    public init(delegate:ContactDelegate , contact:Contact?, maxId:Int64) {
        super.init()
        self.delegate = delegate
        self.model = AddContactModel(delegate: self, contact: contact, maxId:maxId)
    }
    
    func getMobileNumber() -> String?{
        return self.model?.getMobileNumber()
    }
    
    func getEmail() -> String?{
        return self.model?.getEmail()
    }
    
    func getID() -> Int64?{
        return self.model?.getID()
    }
    
    func getFirstName() -> String?{
        return self.model?.getFirstName()
    }
    
    func getLastName() -> String?{
        return self.model?.getLastName()
    }
    
    func getContact() -> Contact? {
        return self.model?.getContact()
    }

    
    // MARK: - Validation Methods
    func isValidMobileNumber(mobileNumber:String?)->Bool{
        if mobileNumber == ""{
            return false
        }
        let characterset = CharacterSet(charactersIn: "0123456789+ ")
        if mobileNumber!.rangeOfCharacter(from: characterset) != nil {
            if mobileNumber!.characters.count > 10{
                if mobileNumber!.hasPrefix("0") || mobileNumber!.hasPrefix("+91"){
                    return true
                }else{
                    return false
                }
            }else if mobileNumber!.characters.count == 10{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
        
    }
    
    func isValidEmail (email : String?) -> (Bool){
        if email == "" {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return (predicate.evaluate(with: email!))
    }
    

    
    // MARK: - Contact Delegates
    func onSuccess() {
        self.delegate?.onSuccess()
    }
    
    func onFailure(message: String) {
        self.delegate?.onFailure(message: message)
    }
    
    func addNewContactToServer(fname:String, lname:String, mobile:String, email:String){
        self.model?.addNewContactToServer(fname: fname, lname: lname, mobile: mobile, email: email)
    }

    func updateContactToServer(fname:String, lname:String, mobile:String, email:String){
        self.model?.updateContactToServer(fname: fname, lname: lname, mobile: mobile, email: email)
    }

    

}
