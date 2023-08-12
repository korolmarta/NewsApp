//
//  ArticleEntity+CoreDataClass.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//
//

import Foundation
import CoreData

public class ArticleEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var source: SourceEntity?
    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
}
