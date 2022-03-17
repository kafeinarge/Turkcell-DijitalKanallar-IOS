//
//  LogoutStart.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 16.03.2022.
//

import Foundation

public final class LogoutManager {
    private var service: LogoutServiceProtocol!
    
    init(service: LogoutServiceProtocol) {
        self.service = service
        self.service.delegate = self
    }
    
    public func logout() {
        self.service.loadLogout()
    }
}

extension LogoutManager: LogoutServiceDelegate {
    public func resultLogout(result: Result<DefaultResponse>) {
        switch result {
        case .success:
            app.router.start()
            Constants.sessionId = ""
            Constants.accountId = -1
        case .failure(let error):
            print(error)
        }
    }
}
