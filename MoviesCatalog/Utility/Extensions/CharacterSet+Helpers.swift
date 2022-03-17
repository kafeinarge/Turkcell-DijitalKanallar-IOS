//
//  CharacterSet+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

extension CharacterSet {
   public static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
