//
//  InBasketViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 18/01/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData

class InBasketViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // categoryId   productName
        
        let context = database.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductTable")
        let sort1 = NSSortDescriptor(key: "categoryId", ascending: true)
        let sort2=NSSortDescriptor(key: "productName", ascending: true)
        fetchRequest.sortDescriptors = [sort1, sort2]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: "categoryId",
                                                              cacheName: "SectionCache")
        fetchedResultsController.delegate =  self
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    func numberOfSectionsInTableView
        (tableView: UITableView) -> Int {
        let sectionInfo =  fetchedResultsController.sections![0]
        
        print("ind: \(sectionInfo.indexTitle ?? "brak")")
        print("name: \(sectionInfo.name)")
        print("obj: \(sectionInfo.numberOfObjects)")
        print("count: \(sectionInfo.objects?.count ?? -1)")

        return fetchedResultsController.sections!.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let sectionInfo =
            fetchedResultsController.sections![section]
        
        return sectionInfo.name
    }
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
       // let sectionInfo = fetchedResultsController.sections![section]
//            print("numb: \(sectionInfo.numberOfObjects)")
//            print("index: \(sectionInfo.indexTitle)")
//            print("name: \(sectionInfo.name)")
//            print("count: \(sectionInfo.objects?.count)")
        return fetchedResultsController.sections?.count  ?? 0  //sectionInfo.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InBasketTableViewCell
        let dlugosc = database.product.productArray.count
        print("dlugosc \(dlugosc) indexPath.row \(indexPath.row)")
        //let tmp = database.product.productArray[indexPath.row < dlugosc  ? indexPath.row: 0]
        let obj=fetchedResultsController.object(at: indexPath) as! ProductTable
        configureCell(cell: cell, withEntity: obj, row: indexPath.row, section: indexPath.section )
        return cell
    }
    func configureCell(cell: InBasketTableViewCell, withEntity product: ProductTable, row: Int, section: Int) {
        cell.detailLabel.text=product.description
        cell.producentLabel.text="aaa\(row),\(section)"
        //cell.productNameLabel.text="cobj"
        cell.productNameLabel.text = product.productName
        cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("<#T##items: Any...##Any#>")
    }
    func firstRunSetupSections(forEntityName entityName : String) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
