//
//  UILabel+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

extension UILabel {
    public func getTextSize() -> CGSize {
        guard let textSize: CGSize = ((self.text as NSString?)?.size(withAttributes: [NSAttributedString.Key.font: self.font!])) else { return .zero}
        return textSize
    }
}

