//
//  AppCoordinator.swift
//  marinehealth-ios
//
//  Created by Александр Гужавин on 01.06.2022.
//

import UIKit
import GoogleMaps

class AppCoordinator: NSObject {
    
    var window: UIWindow
    var router: MainRouter?
    
    init(window: UIWindow?) {
        self.window = window!
        super.init()
        startScreenFlow()
    }
    
    
    
    func didFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
    }
    
    private func startScreenFlow() {
        
        GMSServices.provideAPIKey("AIzaSyBF0aGCVDe_RQ_A-8N7YT40KhcQPAERWYY")
        let navController = UINavigationController()
        router = MainRouter(navigationController: navController)
        if UserDefaults.standard.value(forKey: "authToken") == nil {
            router?.pushLogin()
        } else {
            router?.pushMainMap()
            print(UserDefaults.standard.value(forKey: "authToken"))
        }
        
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }

}
