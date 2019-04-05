//
//  DetailAtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 24.07.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class DetailAtHomeViewController: UIViewController {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productSubtitleLabel: UILabel!
    @IBOutlet var productWeightLabel: UILabel!
    @IBOutlet var eanCodeLabel: UILabel!
    
    
    var productImageName = ""
    var productImageData: Data? = nil
    var productTitle = ""
    var productSubtitle = ""
    var productWeight = ""
    var eanProduct = ""
    
    var numberOfRow = 0
    var aliasOfProductName="moje"
    
    
    override func viewDidLoad() {
        print("DetailAtHomeViewController")
        super.viewDidLoad()
        if productImageData == nil {
            productImageView.image = UIImage(named: "question-mark")
        }
        else {
            productImageView.image = UIImage(data: productImageData!)
        }
               //UIImage(named: productImageName)
        productTitleLabel.text = productTitle
        productSubtitleLabel.text=productSubtitle
        productWeightLabel.text=productWeight
        eanCodeLabel.text=eanProduct
        if(is3Dtouch)
        {
            registerForPreviewing(with: self, sourceView: view)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProductNameButton(_ sender: UIBarButtonItem) {
        let alertController=UIAlertController(title: "Zmiana nazwy", message: "Zmień nazwę produktu lub anuluj zmianę.", preferredStyle: .alert)
        let action1=UIAlertAction(title: "Anuluj", style: .cancel
            , handler: nil)
        
        let action2 = UIAlertAction(title: "Zmień", style: .default) { (action) in
            
            self.productTitleLabel.text=alertController.textFields![0].text
            self.aliasOfProductName=alertController.textFields?[1].text ?? ""
        }
        alertController.addTextField { (text) in
            text.text=self.productTitleLabel.text
        }
        alertController.addTextField { (text) in
            text.placeholder="Skrót nazwy (opcjonalnie)"
            text.text=self.aliasOfProductName
        }

       alertController.addAction(action1)
       alertController.addAction(action2)
        
        present(alertController, animated: true, completion: nil)
       //present(self, animated: true, completion: nil)
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
// MARK: 3D Touch dellegate method
extension DetailAtHomeViewController : UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
      let convertedLocation=view.convert(location, to: productImageView)
        if(productImageView.bounds.contains(convertedLocation)) {
            let popVC=storyboard?.instantiateViewController(withIdentifier: "popVC") as! popViewController
            popVC.popImage = productImageView.image!
            //Set your height
            popVC.preferredContentSize = CGSize(width: 0.0, height: 400)
            previewingContext.sourceRect = productImageView.frame
            return popVC
        }
        else {
          return nil
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let viewController = viewControllerToCommit as? popViewController {
            viewController.back.isHidden=false
        }
        show(viewControllerToCommit, sender: self)
    }
}

