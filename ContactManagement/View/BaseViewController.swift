//
//  BaseViewController.swift
//  ContactManagement
//
//  Created by srinivasan on 28/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingView:LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = Constants.Color.themeColor

    }
    
    func showLoadingView(){
        guard loadingView != nil else {
            loadingView = LoadingView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64))
            self.view.addSubview(loadingView!)
            loadingView?.actiivityIndicator?.startAnimating()
            return;
        }
        loadingView?.isHidden = false;
        loadingView?.actiivityIndicator?.startAnimating()
    }
    
    func removeLoadingView(){
        loadingView?.actiivityIndicator?.stopAnimating();
        loadingView?.isHidden = true;
    }

    
    func showAlertWithOneButtonAndNoAction( title: String, message: String, buttonTitle: String){
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)


    }
    
}
