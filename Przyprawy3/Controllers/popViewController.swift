//
//  popViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 11.09.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class popViewController: UIViewController {
    @IBOutlet var back: UIButton!
    @IBOutlet var photo: UIImageView!
    var popImage=UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image=popImage
        self.back.isHidden=true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
