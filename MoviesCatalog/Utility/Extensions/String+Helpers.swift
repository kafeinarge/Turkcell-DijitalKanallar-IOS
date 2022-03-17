//
//  String+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 14.03.2022.
//

import Foundation

extension String {
  func toReadableDate(withFormat format: String = "yyyy-MM-dd") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      return nil
    }
    
    let toDateFormatter = DateFormatter()
    toDateFormatter.dateFormat = "dd MMM yyyy"
    return toDateFormatter.string(from: date)
  }
}

