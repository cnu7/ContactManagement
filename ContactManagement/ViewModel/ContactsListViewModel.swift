//
//  ContactsListModelView.swift
//  ContactManagement
//
//  Created by srinivasan on 28/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class ContactsListViewModel: NSObject, ContactDelegate {
    
    private var model:ContactsListModel?
    var delegate:ContactDelegate?

    public init(delegate:ContactDelegate) {
        super.init()
        self.delegate = delegate
        self.model = ContactsListModel(delegate:self)
    }

    func getDataCount() -> Int{
        return self.model!.getDataCount()
    }
    
    func getContactAtIndex(index:Int) -> Contact{
        return self.model!.getContactAtIndex(index: index)
    }
    
    func reloadTableWithLocalData(){
        self.model?.reloadTableWithLocalData()
    }
    
    func getMaxId() -> Int64?{
        return self.model?.getMaxId()
    }
       
    // MARK: - Contact Delegates

    func onSuccess() {
        self.delegate?.onSuccess()
    }
    
    func onFailure(message: String) {
        self.delegate?.onFailure(message: message)
    }
    
   

}
