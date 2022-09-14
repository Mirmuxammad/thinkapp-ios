//
//  SignUpView.swift
//  thinkapp-ios
//
//  Created by Mavlon on 14/09/22.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = BaseFont.syneBolt(with: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your email..."
        textField.font = BaseFont.interRegulat(with: 14)
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.borderStyle = .bezel
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.black.cgColor
        button.setTitle("Next", for: .normal)
        button.setTitleColor(BaseColor.black, for: .normal)
        button.tintColor = BaseColor.black
        button.titleLabel?.font = BaseFont.syneBolt(with: 14)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.black.cgColor
        button.setTitleColor(BaseColor.black, for: .normal)
        button.setTitle("Sign up", for: .normal)
        button.tintColor = BaseColor.black
        button.titleLabel?.font = BaseFont.syneBolt(with: 14)
        button.isHidden = true
        return button
    }()
    
    private let verificationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Verification code"
        textField.font = BaseFont.interRegulat(with: 14)
        textField.keyboardType = .numberPad
        textField.borderStyle = .bezel
        textField.isHidden = true
        return textField
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = BaseColor.gray
        addViews()
        addConstraints()
    }
    
    // after sending email
    func didEmailSent() {
        emailTextField.isUserInteractionEnabled = false
        emailTextField.textColor = .systemGray
        nextButton.isHidden = true
        verificationTextField.isHidden = false
        signUpButton.isHidden = false
    }
    
    func nextBtnAddTarget(target: Any, action: Selector) {
        nextButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func signUpBtnAddTarget(target: Any, action: Selector) {
        signUpButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func addViews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(nextButton)
        containerStackView.addArrangedSubview(verificationTextField)
        containerStackView.addArrangedSubview(signUpButton)
    }
    
    private func addConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
}
