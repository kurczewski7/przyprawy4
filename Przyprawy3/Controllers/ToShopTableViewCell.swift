//
//  ToShopTableViewCell.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 20/11/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class ToShopTableViewCell: UITableViewCell {

  
    @IBOutlet var picture: UIImageView!
    @IBOutlet var producentLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
