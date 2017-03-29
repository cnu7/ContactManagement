//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by srinivasan on 29/03/17.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact");
    }

    @NSManaged public var contactId: Int64
    @NSManaged public var contactUrl: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var lastName: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var profilePic: String?

}
