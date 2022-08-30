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
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        baseView.frame = view.bounds
        view.addSubview(baseView)
    }

}
