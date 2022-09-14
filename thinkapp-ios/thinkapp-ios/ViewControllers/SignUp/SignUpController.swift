//
//  SignUpController.swift
//  thinkapp-ios
//
//  Created by Mavlon on 14/09/22.
//

import UIKit

class SignUpController: UIViewController, Routable {
    
    var router: MainRouter?
    
    private let baseView: SignUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.nextBtnAddTarget(target: self, action: #selector(didSentEmailAddres))
        baseView.signUpBtnAddTarget(target: self, action: #selector(didTapSignUp))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        baseView.frame = view.bounds
        view.addSubview(baseView)
    }
    
    @objc private func didSentEmailAddres() {
        baseView.didEmailSent()
    }
    
    @objc private func didTapSignUp() {
        router?.pushWelcome()
    }
    
}
