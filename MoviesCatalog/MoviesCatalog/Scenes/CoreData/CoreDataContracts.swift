//
//  CoreDataContracts.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 17.03.2022.
//

import Foundation

public protocol SearchCoreDataProtocol: AnyObject {
    var delegateSearch: SearchCoreDataDelegate? { set get }
    func saveFavorite(movie: MovieCore, protocolType: ProtocolType)
    func deleteFavorite(id: Int, protocolType: ProtocolType)
    func isContainFavorite(id: Int, protocolType: ProtocolType)
}

public protocol SearchCoreDataDelegate: AnyObject {
    func resultSave(result: Result<[ProtocolType:Bool]>)
    func resultDelete(result: Result<[ProtocolType:Bool]>)
    func resultIsContain(result: Result<[ProtocolType:Bool]>)
}

public protocol ListCoreDataProtocol: AnyObject {
    var delegateList: ListCoreDataDelegate? { set get }
    func fetchList(protocolType: ProtocolType)
}

public protocol ListCoreDataDelegate: AnyObject {
    func resultFetch(result: Result<[MovieCore]>)
}

public protocol WatchListCoreDataProtocol: AnyObject {
    var delegateWatchList: WatchListCoreDataDelegate? { set get }
    func fetchList(protocolType: ProtocolType)
}

public protocol WatchListCoreDataDelegate: AnyObject {
    func resultFetch(result: Result<[MovieCore]>)
}


public enum ProtocolType: String, Equatable {
    case favoriteList = "Favorite"
    case watchList = "WatchList"
}

