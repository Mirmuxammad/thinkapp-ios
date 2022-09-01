//
//  LoginController.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 30.08.2022.
//

import UIKit

class LoginController: UIViewController, Routable {
    
    var router: MainRouter?
    
    private let baseView: LoginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.loginWithMailAddTarget(target: self, action: #selector(loginWithMail))
        baseView.loginWithAppleAddTarget(target: self, action: #selector(loginWithApple))
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        baseView.frame = view.bounds
        view.addSubview(baseView)
    }
    
    @objc private func loginWithMail() {
        router?.pushWelcome()
        print("open email")
    }
    
    @objc private func loginWithApple() {
        print("open apple ID")
    }

}
