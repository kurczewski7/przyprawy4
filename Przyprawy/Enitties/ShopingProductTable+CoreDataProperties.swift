//
//  ShopingProductTable+CoreDataProperties.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28/10/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//
//

import Foundation
import CoreData


extension ShopingProductTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopingProductTable> {
        return NSFetchRequest<ShopingProductTable>(entityName: "ShopingProductTable")
    }

    @NSManaged public var eanCode: String?
    @NSManaged public var id: Int16
    @NSManaged public var productRelation: ProductTable?

}
