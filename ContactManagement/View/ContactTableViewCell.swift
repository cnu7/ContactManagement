//
//  ContactTableViewCell.swift
//  ContactManagement
//
//  Created by srinivasan on 28/03/17.
//  Copyright © 2017 srinivasan. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
