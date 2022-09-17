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
        guard let email = baseView.emailTextField.text else { return }
        LoginAPI.sendCodeEmail(email: email, success: { [weak self] jsonData in
        
        }) { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
    
        baseView.didEmailSent()
    }
    
    @objc private func didTapSignUp() {
        guard let email = baseView.emailTextField.text else { return }
        guard let code = baseView.verificationTextField.text else { return }
        guard let veriCode = Int(code) else { return }
        
        LoginAPI.loginWithEmailCode(email: email, code: code, success: { [weak self] jsonData in
            self?.router?.pushWelcome()
        }) { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
    }
    
}
