//
//  UserDefaults.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 16/09/22.
//

import Foundation

class UserDefaultsService {
    
    public static let sharedInstance = UserDefaultsService()

    private enum Keys {
        static let authToken = "authToken"
        static let userLat = "userLat"
        static let userLon = "userLon"
    }

    func removeAuthToken() {
        self.authToken = nil
    }
        
    var authToken: String? {
        get {
            let authToken = UserDefaults.standard.value(forKey: Keys.authToken) as? String
            return authToken ?? nil
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.authToken)
        }
    }
    
    var userLat: Double? {
        get {
            let userLat = UserDefaults.standard.value(forKey: Keys.userLat) as? Double
            return userLat ?? nil
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.userLat)
        }
    }
    
    var userLon: Double? {
        get {
            let userLon = UserDefaults.standard.value(forKey: Keys.userLon) as? Double
            return userLon ?? nil
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.userLon)
        }
    }
}
