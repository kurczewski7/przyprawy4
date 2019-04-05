//
//  TakePhotoViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 05/12/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

//protocol TakePhotoDelegate {
//
//}
class TakePhotoViewController: UIViewController, UINavigationControllerDelegate ,UIImagePickerControllerDelegate, UIGestureRecognizerDelegate {

    let imagePicker = UIImagePickerController()
    var currentSource : UIImagePickerController.SourceType = .camera
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var eanCodeLabel: UILabel!
    @IBOutlet var productNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTapGesture=UITapGestureRecognizer(target: self, action: #selector(tapUserPhoto(_:)))
        imageTapGesture.delegate = self
        imageTapGesture.numberOfTapsRequired = 1
        photoImageView.addGestureRecognizer(imageTapGesture)
        photoImageView.isUserInteractionEnabled=true
        eanCodeLabel.text=database.scanerCodebarValue
        
        // Add ScreenEdge gesture
        let edgeGestute = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeGesture))
        edgeGestute.edges = .left
        view.addGestureRecognizer(edgeGestute)

        // Do any additional setup after loading the view.
    }
    @objc func screenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge gesture swiped!")
            showMessageToAdd()
        }
    }

    @IBAction func cancelBarButtonTap(_ sender: UIBarButtonItem) {
        print("cancel presed")
        showMessageToAdd()
        //dismiss(animated: true, completion: nil)
    }
    func showMessageToAdd() {
        let allertController=UIAlertController(title: "New product", message: "Do you want add new Product", preferredStyle: .alert)
        let allertActionOk=UIAlertAction(title: "Add prouct", style: .default) { (action) in
            print("OK prress")
            self.addProductWithEan(ean: self.eanCodeLabel.text!, productName: self.productNameTextField.text!, picture: self.photoImageView.image)
            self.dismiss(animated: true, completion: nil)        }
        let allertActionCancel=UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        allertController.addAction(allertActionOk)
        allertController.addAction(allertActionCancel)
        present(allertController, animated: true)
    }
    
    @IBAction func setupBarButtonTap(_ sender: UIBarButtonItem) {
        print("setup")
        let alertController=UIAlertController(title: "Warning", message: "You can change default photo source", preferredStyle: .alert)
        let actionPhotoLibrary=UIAlertAction(title: "Photo Library", style:
        .default) { (action) in
            print("Photo Library")
            self.currentSource = .photoLibrary
        }
        let actionPhotoAlbum=UIAlertAction(title: "Photo Album", style: .default) { (action) in
            print("Photo Album")
            self.currentSource = .savedPhotosAlbum
        }
        let actionCamera=UIAlertAction(title: "Camera", style: .default) { (action) in
            print("Photo Camera")
            self.currentSource = .camera
        }
        let actionCancel=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhotoLibrary)
        alertController.addAction(actionPhotoAlbum)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)

    }
    
    @IBAction func keyboardBarButtonTap(_ sender: UIBarButtonItem) {
        print("keyboard")
        self.view.endEditing(true)
    }
    func addProductWithEan(ean: String, productName: String, picture: UIImage?) {
        let categoryNo: Int = Int(database.selectedCategory?.id ?? 0)
        let productTable=ProductTable(context: database.context)
        productTable.eanCode=ean
        productTable.productName=productName
        productTable.categoryId=Int16(categoryNo)
        productTable.parentCategory=database.selectedCategory
        let pngData=picture?.pngData()
        
        productTable.fullPicture = pngData
        productTable.pictureName="cameraCanon"
        print("\(ean) \(productName)")
        print("category :: \(categoryNo)")
        database.addOneRecord(newProduct: productTable)
       // database.addProduct(withProductId: categoryNo)
    }
    func getPhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(currentSource)
        present(imagePicker, animated: true)
    }
    @IBAction func takePhotoBarButtonTap(_ sender: UIBarButtonItem) {
        getPhoto()
    }
    
    //var currentSourceType UIImagePickerController.SourceType
    
    @IBAction func takePhotoTap(_ sender: Any) {
        getPhoto()
    }
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
         dismiss(animated: true)
    }
    func selectImageFrom( _ source: UIImagePickerController.SourceType) {
        imagePicker.delegate = self
        imagePicker.allowsEditing=true
        imagePicker.sourceType = source
        }
    
    // Delegate method : UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("Image not found")
            return
        }
        photoImageView.image=selectedImage
    }

    @objc func tapUserPhoto(_ sender: UITapGestureRecognizer) {
        print("photo touch")
        getPhoto()
    }
}
