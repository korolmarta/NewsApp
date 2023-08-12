//
//  SourceEntity+CoreDataClass.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//
//

import Foundation
import CoreData

public class SourceEntity: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceEntity> {
        return NSFetchRequest<SourceEntity>(entityName: "SourceEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
}
