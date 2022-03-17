//
//  Dictionary+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

extension Dictionary {
   public func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
    
    public func getJSONData() -> Data {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) as Data
        return jsonData
    }
    
    public func getComponents(urlString: String) -> NSURLComponents {
        let urlComp = try! NSURLComponents(string: urlString).unwrap()
        var items = [URLQueryItem]()

        for (key,value) in self as! [String: String] {
            items.append(URLQueryItem(name: key, value: (value)))
        }

        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
          urlComp.queryItems = items
        }
        
        return urlComp
    }
}

