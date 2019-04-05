//
//  AtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//


// self.table.tableHeaderView = sg
import UIKit

class AtHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DatabaseDelegate {
    var numberOfRow = 0
    var instantSearch = true
    var productMode = true
    var selectedSegmentIndex = 0
    var eanMode: Bool = false
    var productWasAdded=false
    var numberOfRecords = -1
    
    let sg = UISegmentedControl(items: segmentValues)
    
    // MARK: Delegate method
    func updateGUI() {
        table.reloadData()
    }

    @IBOutlet var searchedBar: UISearchBar!
    @IBOutlet var table: UITableView!
    @IBOutlet var keyboradBarBatonIcon: UIBarButtonItem!
    
    // MARK : IBAction
    @IBAction func eanBarcodeButton(_ sender: UIBarButtonItem) {
        self.productWasAdded=false
        self.numberOfRecords = -1
        print("eanBarcodeButton")
        goToViewController(controllerName: "scanerViewController")
        
        //performSegue(withIdentifier: "goScanning", sender: self)
        //self.present(newViewController, animated: true, completion: nil)
        
       
    }
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        print("searchButton")
        database.filterData(searchText: "aMi", searchTable: .products, searchField: .Producent)
        //table.reloadData()
    }
    @IBAction func keyboardModeButton(_ sender: UIBarButtonItem) {
        print("keyboard")
        searchedBar.resignFirstResponder()
    }

    override func viewDidLoad() {
        
        // DatabaseDelegate method
        super.viewDidLoad()
        keyboradBarBatonIcon.isEnabled=true

        initSearchBar(self.searchedBar)
         database.loadData(tableNameType: .products)
         database.delegate = self
         // change beck icon
        let imgBackArrow = UIImage(named: "Cofnij")
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        let sqlText = server.makeSqlTxt(database: database)
        print(sqlText)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        noProductFound()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getNumberOfRecords(numbersOfRecords recNo: Int, eanMode: Bool) {
        self.numberOfRecords=recNo
        self.eanMode=eanMode
    }
    func noProductFound() {
        print("noProductFound: numberOfRecords \(numberOfRecords),eanMode \(eanMode), productWasAdded \(productWasAdded)")
        if numberOfRecords == 0  && eanMode && !productWasAdded {
            let categoryName=database.selectedCategory?.categoryName==nil ? "" :database.selectedCategory?.categoryName!
            let alertController=UIAlertController(title: "Product not found", message: "Product EAN code \(database.scanerCodebarValue) not found in category \(categoryName!). Try in other category or add product. Do you want add new product?", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Add product", style: .default) { (action:      UIAlertAction) in
                print("OK")
                self.addProductWithEan(ean: database.scanerCodebarValue, productName: "ProductName", picture: nil)
                self.productWasAdded = true
            }
            
            let actionCanel=UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
                print("cancel")
                self.productWasAdded = false
                //self.numberOfRecords = -1
            }
            alertController.addAction(actionCanel)
            alertController.addAction(actionOK)
            present(alertController, animated: true)
        }
    }
    
    // MARK - TableView metod
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return picturesArray.count
        return database.product.productArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!   AtHomeCell 
        let product=database.product.productArray[indexPath.row]
        cell.productLabel.text = product.productName?.capitalized(with: nil) ?? "No product"

         //cell.producentLabel?.font.withSize(25)
        cell.producentLabel.text = product.producent?.uppercased()  ?? "No producent"
        cell.descriptionLabel.text =  String(product.weight).lowercased()+"g"                    
        //cell.productPicture.image = UIImage(named:  product.pictureName ?? "question-mark")
        let questionPic=UIImage(named: "question-mark")!.pngData()
        if let pict=UIImage(data: product.fullPicture ?? questionPic!) {
            cell.productPicture.image = pict
        }
        else {
           cell.productPicture.image = UIImage( named: "question-mark")
        }
        cell.accessoryType =  product.checked ? .checkmark : .none
        cell.producentLabel?.font.withSize(25)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt performSegue goToProducts")
        numberOfRow=indexPath.row
        performSegue(withIdentifier: "goToProducts", sender: self)
    }
    // MARK : Editing style
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let currCell=tableView.cellForRow(at: indexPath)
        let isChecked = (currCell?.accessoryType == .checkmark)
        let checkAction=UITableViewRowAction(style: .default, title: " 🧺\nDo koszyka", handler:
        {(action, indexPath) -> Void in
            currCell?.accessoryType = .checkmark
            database.product.productArray[indexPath.row].checked = true
            database.addToBasket(product: database.product.productArray[indexPath.row])
            database.save()
        })
        let uncheckAction=UITableViewRowAction(style: .destructive, title: "❎\nUsuń z koszyka ", handler:
        { (action, indexPath) -> Void in
            currCell?.accessoryType = .none
            database.product.productArray[indexPath.row].checked = false
            database.save()
        })
        checkAction.backgroundColor=UIColor(red: 48.0/255, green: 173.0/255, blue: 99.0/255, alpha: 1.0)
        uncheckAction.backgroundColor=UIColor.red
        return isChecked ? [uncheckAction] : [checkAction]
    }
    func goToViewController(controllerName: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController=storyBoard.instantiateViewController(withIdentifier: controllerName)  //as! TakePhotoViewController "takePhoto"
        self.present(newViewController, animated: true, completion: nil)
    }
    func addProductWithEan(ean: String, productName: String, picture: UIImage?) {
        print("Adding product \(ean)")
        productWasAdded=false
        goToViewController(controllerName: "takePhoto")
    }
    // MARK: SearchBar metod
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked \(searchBar.text!)")
        database.filterData(searchText: searchBar.text!, searchTable: .products, searchField: (self.selectedSegmentIndex==0 ? .Product : .Producent))
        DispatchQueue.main.async {
            self.searchedBar.resignFirstResponder()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("changed \(searchBar.text!)")
        database.filterData(searchText: searchBar.text!, searchTable: .products, searchField: (self.selectedSegmentIndex==0 ? .Product : .Producent))
    }
    
    // MARK: - My own methods
    func initSearchBar(_ searchBar: UISearchBar)
    {
        searchBar.placeholder=self.giveProductPrompt(with: true)[0]

        sg.removeAllSegments()
        sg.insertSegment(withTitle: giveProductPrompt(with: false)[0], at: 0, animated: false)
        sg.insertSegment(withTitle: giveProductPrompt(with: false)[1], at: 1, animated: false)
        sg.selectedSegmentIndex = 0
        self.selectedSegmentIndex = 0
        //segmetedControl.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents:)
        //addTarget(self, action: #selector(changeWebView), for: .valueChanged)
        sg.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        self.table.tableHeaderView = sg
        table.sectionHeaderHeight = 100
        
        //self.table.tableHeaderView?.backgroundColor=UIColor.yellow
        //let ssgg = self.table.tableHeaderView as! UISegmentedControl
    }
    func searchBarTextDidBeginEditing(){
        print("searchBarTextDidBeginEditing")
        
    }
    @objc func segmentedControlValueChanged(segment: UISegmentedControl)
    {
        print("segment changed \(segment.selectedSegmentIndex)")
        self.selectedSegmentIndex = segment.selectedSegmentIndex
        if (searchedBar.text?.isEmpty)!
        {
            searchedBar.placeholder =  giveProductPrompt(with: true)[segment.selectedSegmentIndex]
        }
    }    
    func giveProductPrompt(with isPlaceholder:Bool) -> [String]
    {
        var myPrompt = [String]()
        if(polishLanguage)
        {
           myPrompt = (isPlaceholder ? ["Wyszukaj produkt 🌶","Wyszukaj producenta 🔧"] : ["🌶 Produkt ","🔧 Producent "] )
        }
        else
        {
            myPrompt = (isPlaceholder ? ["Find your product 🌶","Find your producent 🔧"] : ["🌶 Product ","🔧 Producent "] )
        }
        return myPrompt
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue goToProducts")
        if segue.identifier=="goToProducts"
        {
            let nextVC=segue.destination as! DetailAtHomeViewController
            nextVC.numberOfRow = numberOfRow
            let currentProduct = database.product.productArray[numberOfRow]
            nextVC.productImageName = currentProduct.pictureName ?? "question-mark"
            nextVC.productTitle = currentProduct.productName ?? "no product"
            nextVC.productSubtitle = currentProduct.producent ?? "no producent"
            nextVC.productWeight = "\(currentProduct.weight)g"
            nextVC.eanProduct = currentProduct.eanCode==nil ?  "" :"EAN: \(currentProduct.eanCode!)"
            nextVC.productImageData = currentProduct.fullPicture
        }
    }

//        searchBar.showsScopeBar=true
//        searchBar.scopeButtonTitles=["name", "Producenr","gggg"]
//        searchBar.selectedScopeButtonIndex=0
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }

}
