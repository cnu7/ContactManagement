//
//  Constants.swift
//  ContactManagement
//
//  Created by srinivasan on 28/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Url{
        static let baseURL = "https://gojek-contacts-app.herokuapp.com/"
        static let getContactsList = "contacts.json"
        static let postNewContact = "contacts.json"
        static func getContactDetailsForID(contactID : Int64)->String
        {
            
            return "contacts/\(contactID).json"
        }
        
        static func updateContactDetailsForID(contactID : Int64)->String
        {
            
            return "contacts/\(contactID).json"
        }
        
    }
    struct Color {
        static let themeColor = UIColor(red: 77/255, green: 236/255, blue: 194/255, alpha: 1)
    }
}
