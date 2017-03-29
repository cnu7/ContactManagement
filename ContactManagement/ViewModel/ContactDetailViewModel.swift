//
//  ContactDetailViewModel.swift
//  ContactManagement
//
//  Created by srinivasan on 29/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import Foundation
import MessageUI

class ContactDetailViewModel: NSObject, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, ContactDelegate {
    
    private var model:ContactDetailModel?
    var delegate:ContactDelegate?
    
    public init(delegate:ContactDelegate , contact:Contact) {
        super.init()
        self.delegate = delegate
        self.model = ContactDetailModel(delegate: self, contact: contact)
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
    
    func getIsFavourite() -> Bool?{
        return self.model?.getIsFavourite()
    }
    
    func getName() -> String?{
        return self.model?.getName()
    }
    
    func getContact() -> Contact {
        return self.model!.getContact()
    }
    
    func saveContactIsFavouriteToDB(isFavourite:Bool){
        self.model?.saveContactIsFavouriteToDB(isFavourite: isFavourite)
    }
    
    func deleteContact(){
        self.model?.deleteContact()
    }
    
    
    // MARK: - Call/Email/SMS methods

    func makeCall(viewController:UIViewController){
        guard let mobileNumber = self.model!.getMobileNumber() else {
            (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
            let alert = UIAlertController(title: "", message: "Invalid mobile number!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
            return;
        }
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(mobileNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(phoneCallURL as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(phoneCallURL as URL)
                }
            }
        }
    }
    
    
    
    func sendEmail(viewController:UIViewController){
        guard let email = self.model!.getEmail() else {
            (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
            let alert = UIAlertController(title: "", message: "Invalid email!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
            return;
        }
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setSubject("Bon Jour")
            composeVC.setToRecipients([email])
            viewController.present(composeVC, animated: true, completion: nil)
        }
        
    }
    

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendMessage(viewController:UIViewController){
        guard let mobileNumber = self.model!.getMobileNumber() else {
            (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
            let alert = UIAlertController(title: "", message: "Invalid mobile number!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
            return;
        }
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Bon Jour"
            controller.recipients = [mobileNumber]
            controller.messageComposeDelegate = self
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Contact Delegates
    func onSuccess() {
        self.delegate?.onSuccess()
    }
    
    func onFailure(message: String) {
        self.delegate?.onFailure(message: message)
    }
   


}
