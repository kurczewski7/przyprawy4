//
//  AtHomeCell.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class AtHomeCell: UITableViewCell {
// MARK - Outlet variables
    @IBOutlet var producentLabel: UILabel!
    @IBOutlet var productLabel: UILabel!   
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var productPicture: UIImageView!
     //@IBOutlet var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
