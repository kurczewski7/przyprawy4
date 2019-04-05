//
//  BasketProductTable+CoreDataProperties.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28/10/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//
//

import Foundation
import CoreData


extension BasketProductTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketProductTable> {
        return NSFetchRequest<BasketProductTable>(entityName: "BasketProductTable")
    }

    @NSManaged public var eanCode: Int16
    @NSManaged public var id: Int16
    @NSManaged public var productRelation: ProductTable?

}
