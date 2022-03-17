//
//  LoginPresentation.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import Foundation

public final class LoginPresentation: NSObject {
    public let sessionId: String
    
    public init(sessionId: String) {
        self.sessionId = sessionId
        super.init()
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? LoginPresentation else { return false }
        return other.sessionId == self.sessionId
    }
}

extension LoginPresentation {
    convenience init(login: Login) {
        self.init(sessionId: login.sessionId)
    }
}

