//
//  LoginView.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 30.08.2022.
//

import UIKit
import SnapKit

class LoginView: UIView {

    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_top")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let topLable: UILabel = {
        let lable = UILabel()
        lable.textColor = BaseColor.gray.path
        lable.font = BaseFont.syneBolt(24).path
        lable.text = "Think"
        return lable
    }()
    
    private let centrLable: UILabel = {
        let lable = UILabel()
        lable.textColor = BaseColor.black.path
        lable.font = BaseFont.syneBolt(22).path
        lable.text = "Want to Join Us?"
        return lable
    }()
    
    private let centrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_man")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomLable: UILabel = {
        let lable = UILabel()
        lable.textColor = BaseColor.black.path
        lable.font = BaseFont.syneBolt(18).path
        lable.text = "2165 person think right now!"
        return lable
    }()
    
    private let loginWithAppleButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 5
        button.layer.borderColor = BaseColor.black.path.cgColor
        button.setTitle("Join with apple", for: .normal)
        button.setImage(UIImage(systemName: "applelogo"), for: .normal)
        button.tintColor = BaseColor.black.path
        button.titleLabel?.font = BaseFont.syneBolt(14).path
        button.contentHorizontalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 16)
        return button
    }()
    
    private let loginWithMailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join with mail", for: .normal)
        button.setImage(UIImage(systemName: "envelope"), for: .normal)
        button.tintColor = BaseColor.black.path
        button.titleLabel?.font = BaseFont.syneBolt(11).path
        button.contentHorizontalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 16)
        return button
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = BaseColor.gray.path
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        addSubview(topImageView)
        addSubview(topLable)
        addSubview(centrLable)
        addSubview(centrImageView)
        addSubview(bottomLable)
        addSubview(loginWithAppleButton)
        addSubview(loginWithMailButton)
    }
    
    private func addConstraints() {
        
        topImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(self.frame.height / 3.8)
        }
        
        topLable.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.snp.centerX).offset(4)
        }
        
        centrLable.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        centrImageView.snp.makeConstraints { make in
            make.top.equalTo(centrLable.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.frame.width / 2)
            make.height.equalTo(self.frame.height / 3)
        }
        
        bottomLable.snp.makeConstraints { make in
            make.top.equalTo(centrImageView.snp.bottom).offset(36)
            make.centerX.equalToSuperview().offset(-28)
        }
        
        loginWithAppleButton.snp.makeConstraints { make in
            make.top.equalTo(bottomLable.snp.bottom).offset(44)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.frame.width / 2)
            make.height.equalTo(self.frame.width / 8)
        }
        
        loginWithMailButton.snp.makeConstraints { make in
            make.top.equalTo(loginWithAppleButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
    }
    
    

}
