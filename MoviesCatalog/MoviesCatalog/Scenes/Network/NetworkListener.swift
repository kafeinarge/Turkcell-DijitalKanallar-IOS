//
//  NetworkListener.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 18.03.2022.
//

import UIKit
import Reachability

final class NetworkListener {
    private let notification = Notification.Name("NetworkListenerStatusDidChanged")
    private let reachability: Reachability!
    /// Return true if connected to Internet
    private(set) var isConnected: Bool!
    
    init() {
        guard let safeReachability = try? Reachability() else {
            reachability = try! Reachability()
            return
        }
        reachability = safeReachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            isConnected = true
        case .unavailable, .none:
            isConnected = false
        }
                
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
          try reachability.startNotifier()
        }catch{
          print("could not start reachability notifier")
        }
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    /// Start monitoring network status changed
    ///
    /// - Parameter reachabilityChanged: status changed
    @objc func reachabilityChanged(note: Notification) {
      let reachability = note.object as! Reachability
        
      switch reachability.connection {
      case .wifi, .cellular:
        self.isConnected = true
        app.router.start()
      case .unavailable, .none:
        self.isConnected = false
        app.router.startWithTabBarOfflineMode()
      }
    }
}
