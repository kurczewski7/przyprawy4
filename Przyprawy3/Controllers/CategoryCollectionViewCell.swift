//
//  CategoryCollectionViewCell.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14/11/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
   // @IBOutlet var picture: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    @IBAction func likePressedButton(_ sender: UIButton) {
        print("like presed")
        likeButton.imageView?.image = UIImage(named: "heartfull.png")
        
    }
}
