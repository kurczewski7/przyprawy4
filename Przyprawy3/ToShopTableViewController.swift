//
//  ToShopTableViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 20/11/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class ToShopTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    var keyboarActive = false
    
    @IBOutlet var tabView: UITableView!
    @IBOutlet var searchedBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        database.loadData(tableNameType: .toShop)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        let longTap:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(goToNextViwecontroller))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(longTap)
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func hideKeyboard() {
        print("keyboarActive \(keyboarActive), view.isFocused \(view.isFocused),isFirstResponder \(view.isFirstResponder) ")
        view.endEditing(true)
    }
    @objc func goToNextViwecontroller() {
        print("goToNextViwecontroller")
    }

    override func viewWillAppear(_ animated: Bool) {
        database.loadData(tableNameType: .toShop)
        database.category.crateCategoryGroups(forToShopProduct: database.toShopProductArray)
        //database.category.createSectionsData()
        tabView.reloadData()
        print("viewWillAppear")
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         print("numberOfSections \(database.category.sectionsData.count))")
        return database.category.sectionsData.count
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection \(database.category.getCurrentSectionCount(forSection: section))")
        return   database.category.getCurrentSectionCount(forSection: section)
    }
    func getToShopProduct(indexPath: IndexPath) -> ProductTable?  {
        let prodNumber=database.category.sectionsData[indexPath.section].objects[indexPath.row]
        let  xxx = prodNumber < database.toShopProductArray.count ? prodNumber : database.toShopProductArray.count-1
        let toShopProduct = database.toShopProductArray[xxx].productRelation
        return toShopProduct
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("section:\(indexPath.section) row:\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! ToShopTableViewCell
        let toShop=getToShopProduct(indexPath: indexPath)
        if toShop != nil {
            
            cell.producentLabel.text = toShop?.producent
            cell.productNameLabel.text = toShop?.productName
            let grams="\(toShop?.weight ?? 0)g"
            cell.detailLabel.text = grams.count==2 ? "" : grams
            if let img=toShop?.fullPicture {
                cell.picture.image = UIImage(data: img)
            }
            else {
                cell.picture.image = UIImage(named: "question-mark")
            }
        }
        else {
            cell.producentLabel.text="Brak produktu"
            cell.picture.image=nil
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label=UILabel()
        let sectionName = database.category.getCategorySectionHeader(forSection: section)
        label.text="\(sectionName)"
        label.textAlignment = .center
        label.backgroundColor=UIColor.lightGray
        return label
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let checkAction=UITableViewRowAction(style: .default, title: "🛍\nKup") { (action, indexPath) in
//        }
//        let uncheckAction=UITableViewRowAction(style: .default, title: "🗑\nZwróć") { (action, indexPath) in
//        }
//        checkAction.backgroundColor=UIColor.green
//        uncheckAction.backgroundColor=UIColor.red
//        return [checkAction,uncheckAction]
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
              print("Kasowanie")
              //database.toShopProductArray.remove(at: indexPath.row)
              tableView.beginUpdates()
            
            database.category.deleteElement(forIndexpath: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
              tableView.endUpdates()
              tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        //tap.cancelsTouchesInView = true
        if !keyboarActive {
            print("GO TO ...")
        }
        else {
            print("No to GO ...")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    //     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    //    }
    


    // Override to support conditional rearranging of the table view.
    //     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
    //        return true
    //    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 // Serach bar delegate
    //searchBarTextDidBeginEditin
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked \(searchBar.text!)")
        //database.filterData(searchText: searchBar.text!, searchTable: .products, searchField: (self.selectedSegmentIndex==0 ? .Product : .Producent))
        DispatchQueue.main.async {
            self.searchedBar.resignFirstResponder()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("changed \(searchBar.text!)")
        //database.filterData(searchText: searchBar.text!, searchTable: .products, searchField: (self.selectedSegmentIndex==0 ? .Product : .Producent))
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        keyboarActive = true
        print("searchBarTextDidBeginEditing \(keyboarActive)")
    }
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        keyboarActive = false
//        print("searchBarShouldEndEditing \(keyboarActive)")
//        return true
//    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        keyboarActive = false
        print("searchBarTextDidEndEditing \(keyboarActive)")
        view.endEditing(true)
        //view.resignFirstResponder()
    }
}
