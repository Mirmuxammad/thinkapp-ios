//
//  WelcomeView.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit
import SnapKit

class WelcomeView: UIView {

    private let thinkLable: UILabel = {
        let lable = UILabel()
        lable.font = BaseFont.syneRegular(with: 28)
        lable.textColor = BaseColor.yellow
        lable.text = "Think"
        return lable
    }()
    
    private let cloudImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "welcome_cloud")
        return image
    }()
    
    private let welcomeLable: UILabel = {
        let lable = UILabel()
        lable.font = BaseFont.syneBolt(with: 32)
        lable.textColor = BaseColor.yellow
        lable.text = "Hi, Welcome"
        return lable
    }()
    
    private let subWelcomeLable: UILabel = {
        let lable = UILabel()
        lable.font = BaseFont.syneRegular(with: 28)
        lable.textColor = BaseColor.yellow
        lable.text = "To Think"
        return lable
    }()
    
    private let getStartLable: UILabel = {
        let lable = UILabel()
        lable.font = BaseFont.syneRegular(with: 14)
        lable.textColor = BaseColor.gray
        lable.text = "Get started with app where you can find some peace"
        lable.numberOfLines = 2
        lable.textAlignment = .center
        return lable
    }()
    
    private let mensImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "welcome_mans")
        return image
    }()
    
    private let getStartButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 5
        button.layer.borderColor = BaseColor.black.cgColor
        button.setTitle("Get Started", for: .normal)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = BaseColor.black
        button.backgroundColor = BaseColor.yellow
        button.titleLabel?.font = BaseFont.syneBolt(with: 14)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = BaseColor.darckBlue
        addViews()
        addConstraints()
        print(mensImage.frame.height, frame.height)
    }
    
    func getStartAddTarget(target: Any, action: Selector) {
        getStartButton.addTarget(target, action: action, for: .touchUpInside)
    }

    
    private func addViews() {
        addSubview(thinkLable)
        addSubview(cloudImage)
        addSubview(welcomeLable)
        addSubview(subWelcomeLable)
        addSubview(getStartLable)
        addSubview(mensImage)
        addSubview(getStartButton)
    }
    
    private func addConstraints() {
        thinkLable.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(self.snp.centerX).offset(16)
        }
        cloudImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(thinkLable.snp.bottom).offset(26)
        }
        welcomeLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cloudImage.snp.bottom).offset(26)
        }
        subWelcomeLable.snp.makeConstraints { make in
            make.top.equalTo(welcomeLable.snp.bottom).offset(8)
            make.centerX.equalToSuperview().offset(-26)
        }
        getStartLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subWelcomeLable.snp.bottom).offset(8)
            make.width.equalTo(200)
        }
        mensImage.snp.makeConstraints { make in
            if frame.height > 800 {
                make.top.equalTo(getStartLable.snp.bottom).offset(8)
                make.left.right.equalToSuperview()
            } else {
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(120)
            }

        }
        
        getStartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(self.frame.width / 2)
            make.height.equalTo(self.frame.width / 8)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        
    }
    
    

}
