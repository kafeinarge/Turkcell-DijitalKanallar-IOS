//
//  CoreDataManager.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 17.03.2022.
//

import UIKit
import CoreData

public final class CoreDataManager: SearchCoreDataProtocol, ListCoreDataProtocol, WatchListCoreDataProtocol {
    public weak var delegateList: ListCoreDataDelegate?
    public weak var delegateSearch: SearchCoreDataDelegate?
    public weak var delegateWatchList: WatchListCoreDataDelegate?
    
    public init () {}
    
    public func fetchList(protocolType: ProtocolType) {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntityName)
        
        do {
            var list: [MovieCore] = []
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects as! [NSManagedObject] {
                let id = object.value(forKey: "id") as! Int
                let title = object.value(forKey: "title") as! String
                let image = object.value(forKey: "image") as! Data
                let type = object.value(forKey: "type") as! String
                
                if protocolType.rawValue == type {
                    list.append(MovieCore.init(id: id, title: title, image: image, type: type))
                }
            }
            if protocolType == .watchList {
                delegateWatchList?.resultFetch(result: .success(list))
            } else {
                delegateList?.resultFetch(result: .success(list))
            }
        } catch (let error) {
            if protocolType == .watchList {
                delegateWatchList?.resultFetch(result: .failure(Error.serializationError(error)))
            } else {
                delegateList?.resultFetch(result: .failure(Error.serializationError(error)))
            }
        }
    }
    
    public func deleteFavorite(id: Int, protocolType: ProtocolType)  {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntityName)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var isContain: Bool = true
            for object in objects as! [NSManagedObject] {
                if let uniq = object.value(forKey: "id") as? Int {
                    if uniq == id {
                        if let type = object.value(forKey: "type") as? String {
                            if type == protocolType.rawValue {
                                isContain = false
                                managedContext.delete(object)
                                break
                            }
                        }
                    }
                }
            }
            
            do {
                try managedContext.save()
                delegateSearch?.resultDelete(result: .success([protocolType:isContain]))
            } catch (let error) {
                delegateSearch?.resultDelete(result: .failure(error as! Error))
            }
        
           
            
        } catch (let error) {
            delegateSearch?.resultDelete(result: .failure(error as! Error))
        }
        
    }
    
    public func saveFavorite(movie: MovieCore, protocolType: ProtocolType){
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let movieEntity = NSEntityDescription.entity(forEntityName: Constants.coreDataEntityName, in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        let favoriteMovie = NSManagedObject(entity: movieEntity, insertInto: managedContext)
        favoriteMovie.setValue(movie.id, forKeyPath: "id")
        favoriteMovie.setValue(movie.title, forKey: "title")
        favoriteMovie.setValue(movie.image, forKey: "image")
        favoriteMovie.setValue(movie.type, forKey: "type")
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            delegateSearch?.resultSave(result: .success([protocolType:true]))
        } catch (let error) {
            delegateSearch?.resultSave(result: .failure(error as! Error))
        }
    }
    
    public func isContainFavorite(id: Int, protocolType: ProtocolType) {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.coreDataEntityName)
        var isContain: Bool = false
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects as! [NSManagedObject] {
                if let uniq = object.value(forKey: "id") as? Int {
                    if uniq == id {
                        if let type = object.value(forKey: "type") as? String {
                            if type == protocolType.rawValue {
                                isContain = true
                                break
                            }
                        }
                    }
                }
            }
            delegateSearch?.resultIsContain(result: .success([protocolType:isContain]))
        } catch (let error) {
            delegateSearch?.resultIsContain(result: .failure(error as! Error))
        }
    }
    
}

