//
//  Constants.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import UIKit

public enum Constants {

    /// Session Id
    public static var sessionId: String = ""
    public static var accountId: Int = 0
    public static var baseImageUrl: String = "http://46.101.105.123:8080/movie/imagine?file_path="
    public static var ud = UserDefaults()
  
    /// Core Data Model Name
    public static let coreDataName: String = "MovieCoreModel"
    public static let coreDataEntityName: String = "MovieCoreEntity"
    
    
    /// Message Errors
    public static let appDelegateMessageError = "AppDelegate was not found"
    public static let deleteMessageError = "Movie was deleted successfully"
    public static let OfflineModeTitle = "Offline Mode Active"
}
