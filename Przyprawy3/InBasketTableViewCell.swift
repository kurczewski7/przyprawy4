//
//  InBasketTableViewCell.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 18/01/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class InBasketTableViewCell: UITableViewCell {
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var producentLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
