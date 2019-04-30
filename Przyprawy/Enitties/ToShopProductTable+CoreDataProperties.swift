//
//  ToShopProductTable+CoreDataProperties.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28/10/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//
//

import Foundation
import CoreData


extension ToShopProductTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToShopProductTable> {
        return NSFetchRequest<ToShopProductTable>(entityName: "ToShopProductTable")
    }

    @NSManaged public var changeDate: NSDate?
    @NSManaged public var eanCode: String?
    @NSManaged public var id: Int16
    @NSManaged public var productRelation: ProductTable?

}
