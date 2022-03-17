//
//  NSLocalized+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

extension String {
   public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
   public func localized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
}
