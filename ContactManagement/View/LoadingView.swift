//
//  LoadingView.swift
//  ContactManagement
//
//  Created by srinivasan on 28/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    var actiivityIndicator:UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        actiivityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.frame.size.width/2 - 20, y: self.frame.size.height/2 - 20, width: 40, height: 40))
        self.addSubview(actiivityIndicator!)
    }

}
