//
//  AppCoordinator.swift
//  marinehealth-ios
//
//  Created by Александр Гужавин on 01.06.2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

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
        GMSPlacesClient.provideAPIKey("AIzaSyBF0aGCVDe_RQ_A-8N7YT40KhcQPAERWYY")
        
        let navController = UINavigationController()
        router = MainRouter(navigationController: navController)
        
        if let _ = UserDefaultsService.sharedInstance.authToken {
            router?.pushMainMap()
        } else {
            router?.pushLogin()
        }
        
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }

}
