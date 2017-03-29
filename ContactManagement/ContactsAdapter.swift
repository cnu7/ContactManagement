//
//  ContactsAdapter.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactsAdapter: NSObject {
    
    static let contactAdapterSharedInstance = ContactsAdapter()
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func insertContact(){
        let context = getContext()
        do {
            try context.save()
//            print("saved")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func saveContact (id:Int,firstName:String, lastName: String,profilePic:String,url:String,isFavourite:Bool) {
        
        if self.getContactForId(id: id) != nil{
//            print("contact with id \(id) is already existing")
            return
        }
        
        let context = getContext()
        
        let entity =  NSEntityDescription.entity(forEntityName: "Contact", in: context)
        
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        
        contact.setValue(id, forKey: "contactId")
        contact.setValue(firstName, forKey: "firstName")
        contact.setValue(lastName, forKey: "lastName")
        contact.setValue(profilePic, forKey: "profilePic")
        contact.setValue(url, forKey: "contactUrl")
        contact.setValue(isFavourite, forKey: "isFavourite")
        
        do {
            try context.save()
//            print("saved")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func saveContactDataById(id:Int,mobile:String,email:String){
        if let contact = self.getContactForId(id: id){
            contact.mobileNumber = mobile
            contact.email = email
            self.insertContact()
        }else{
            print("contact id is not present")
        }
    }
    
    func saveContactDataById(id:Int,fname:String, lname:String, mobile:String,email:String){
        if let contact = self.getContactForId(id: id){
            contact.mobileNumber = mobile
            contact.email = email
            contact.firstName = fname
            contact.lastName = lname
            self.insertContact()
        }else{
            print("contact id is not present")
        }
    }
    
    func saveContactIsFavouriteById(id:Int,isFavourite:Bool){
        if let contact = self.getContactForId(id: id){
            contact.isFavourite = isFavourite
            self.insertContact()
        }else{
            //            print("contact id is not present")
        }
    }
    
    func deleteContactById(id:Int64){
        let context = getContext()
        if let contact = self.getContactForId(id: Int(id)){
            context.delete(contact )
            do {
                try context.save()
            } catch _ {
            }

        }
    }
    
    func getContactForId(id:Int)->Contact?{
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        let predicate_id:NSPredicate = NSPredicate(format: "contactId == \(id)")
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates:[predicate_id])
        
        fetchRequest.predicate = compound
        do{
            let syncDatas = try getContext().fetch(fetchRequest) as NSArray?
            
            if (syncDatas?.count)! > 0 {
                return syncDatas?.lastObject as? Contact
            }
        }
        catch{}
        return nil
    }
    
    func getContacts()->[Contact]?{
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            
//            print ("results count = \(searchResults.count)")
            if searchResults.count > 0{
                return searchResults
            }else{
                return nil
            }
        } catch {
            print("Error with request: \(error)")
            return nil
        }
    }
    
}
