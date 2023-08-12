//
//  CoreDataService.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()
    
    func saveContext(completion: @escaping (Bool) -> ()) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(true)
            } catch {
                print("Failed to save Core Data context: \(error)")
                completion(false)
            }
        }
    }
    
    func fetchArticles() -> [ArticleEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest = ArticleEntity.fetchRequest()
        
        do {
            let articles = try context.fetch(fetchRequest)
            return articles
        } catch {
            print("Error fetching articles: \(error)")
            return []
        }
    }
    
    func addArticle(articleData: Article, completion: @escaping (Bool) -> ()) {
        let context = persistentContainer.viewContext
        let article = ArticleEntity(context: context)
        
        article.source = SourceEntity(context: context)
        article.source?.id = articleData.source?.id
        article.source?.name = articleData.source?.name
        
        article.author = articleData.author
        article.title = articleData.title
        article.descriptionText = articleData.description
        article.url = articleData.url
        article.urlToImage = articleData.urlToImage
        article.publishedAt = articleData.publishedAt
        article.content = articleData.content
        
        saveContext() { completion($0) }
    }
    
    func deleteArticle(article: ArticleEntity, completion: @escaping (Bool) -> ()) {
        let context = persistentContainer.viewContext
        context.delete(article)
        saveContext() { completion($0) }
    }
}
