//
//  ContactDetailsTVC.swift
//  EPITA
//
//  Created by Srikanth Karra on 1/16/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class ContactDetailsTVC: UITableViewCell {
    @IBOutlet var labelName: UILabel!
    
    @IBOutlet var labelStreet: UILabel!
    @IBOutlet var labelCity: UILabel!
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var labelPhone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
