//
//  MainRouter.swift
//  marinehealth-ios
//
//  Created by Александр Гужавин on 01.06.2022.
//

import Foundation
import UIKit

protocol Routable: UIViewController {
    
    var router: MainRouter? { get set }
}

class MainRouter: NSObject {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController = navigationController
    }
        
    func pushAddMark() {
        let storyBoard = UIStoryboard(name: "AddMark", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddMark")
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func pushFilters() {
        let vc = FiltersViewController()
        pushViewController(vc: vc)
    }
    
    func pushMainMap() {
        let vc = MainMapController()
        pushViewController(vc: vc)
    }
    
    func pushWelcome() {
        let vc = WelcomeController()
        pushViewController(vc: vc)
    }
    
    func pushLogin() {
        let vc = LoginController()
        pushViewController(vc: vc)
    }
    
    
    private func pushViewController(vc: Routable) {
        vc.router = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func presentViewController(vc: Routable, animated: Bool) {
        vc.router = self
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
