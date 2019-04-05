//
//  ProductTable+CoreDataProperties.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28/10/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductTable> {
        return NSFetchRequest<ProductTable>(entityName: "ProductTable")
    }

    @NSManaged public var changeDate: NSDate?
    @NSManaged public var eanCode: String?
    @NSManaged public var id: Int32
    @NSManaged public var number1: Int16
    @NSManaged public var number2: Int16
    @NSManaged public var number3: Int16
    @NSManaged public var pictureName: String?
    @NSManaged public var producent: String?
    @NSManaged public var productName: String?
    @NSManaged public var searchTag: String?
    @NSManaged public var weight: Int16

}
