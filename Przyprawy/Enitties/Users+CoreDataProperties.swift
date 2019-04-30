//
//  Users+CoreDataProperties.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28/10/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var id: Int16
    @NSManaged public var userEmail: String?
    @NSManaged public var userName: String?
    @NSManaged public var userPhoneNumber: String?

}
