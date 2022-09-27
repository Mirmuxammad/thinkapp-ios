//
//  CustomAnnotationView.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 19/09/22.
//

import UIKit
import MapKit

class CustomAnnotationView: UIView {

    var viewClass: Int = 0
    var markInfo: MapMarkResponce?
    
    
    let contenerViwe: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let onlineIndicator: UIView = {
       let view = UIView()
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let avatar: UIImageView = {
       let img = UIImageView()
       img.layer.cornerRadius = img.layer.frame.height / 2
        img.image = UIImage(named: "user")
       return img
    }()
    
    let nameTitle: UILabel = {
        let label = UILabel()
        label.text = "eva trost"
        label.font = label.font.withSize(13)
        label.textAlignment = .center
        label.text?.suffix(1).uppercased()
        return label
    }()
    
    let onlineTitle: UILabel = {
       let label = UILabel()
        label.text = "online"
        label.textColor = .gray
        label.font = label.font.withSize(10)
        return label
    }()
    
    let springyViewFirst: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FE5880")
        view.layer.cornerRadius = view.layer.frame.height / 2
        return view
    }()
    
    let springyViewSecond: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 3
        return view
    }()
    
    let springyLable: UILabel = {
       let label = UILabel()
        label.text = "T"
        label.font = label.font.withSize(12)
        label.textColor = .white
        return label
    }()
    
    let textLabel: UILabel = {
       let label = UILabel()
        label.text = "Я бегать в 14 00, кто со мной?"
        label.font = label.font.withSize(12)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let locationImage: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "location")
        img.tintColor = UIColor(hex: "#978F8F")
        return img
    }()
    
    let locationLabel: UILabel = {
       let label = UILabel()
        label.font = BaseFont.interRegulat(with: 12)
        label.textColor = UIColor(hex: "#978F8F")
        label.textAlignment = .left
        label.text = "Mukumiy 21"
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            addViews()
        
        upDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
     func upDate() {
        if markInfo?.user.online == false {
            onlineIndicator.backgroundColor = .gray
            onlineTitle.text = "Offline"
        } else {
            onlineIndicator.backgroundColor = .green
            onlineTitle.text = "Online"
        }
        if markInfo?.user.name == "" {
            nameTitle.isHidden = true
        } else {
            nameTitle.isHidden = false
            nameTitle.text = markInfo?.user.name
        }
        springyLable.text = markInfo?.user.name?.first?.uppercased()
        textLabel.text = markInfo?.text
    }
    
    private func addViews() {
        addSubview(contenerViwe)
        contenerViwe.addSubview(containerStackView)
        contenerViwe.addSubview(backButton)
        containerStackView.addSubview(nameTitle)
        containerStackView.addSubview(onlineTitle)
        containerStackView.addSubview(avatar)
        avatar.addSubview(onlineIndicator)
        containerStackView.addSubview(springyViewFirst)
        springyViewFirst.addSubview(springyViewSecond)
        springyViewSecond.addSubview(springyLable)
        containerStackView.addSubview(textLabel)
        containerStackView.addSubview(locationImage)
        containerStackView.addSubview(locationLabel)
    }
    
     func addConstraints() {
        
        contenerViwe.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.right.left.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        avatar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(42)
        }
        
        nameTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(avatar.snp.right).offset(10)
        }
        
        onlineTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(5)
            make.left.equalTo(nameTitle.snp.left)
        }
        
        onlineIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(6)
        }
        
        springyViewFirst.snp.makeConstraints { make in
            make.centerY.equalTo(avatar.snp.centerY)
            make.left.equalTo(nameTitle.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(20)
        }
        
        springyViewSecond.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        springyLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.width.equalTo(15)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImage.snp.centerY)
            make.left.equalTo(locationImage.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        avatar.layer.cornerRadius = avatar.layer.frame.height / 2
        springyViewFirst.layer.cornerRadius = springyViewFirst.layer.frame.height / 2
        springyViewSecond.layer.cornerRadius = springyViewSecond.layer.frame.height / 2
        onlineIndicator.layer.cornerRadius = onlineIndicator.layer.frame.height / 2
        
    }
    
    func addConstraintsNotText() {
        contenerViwe.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.right.left.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        avatar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(42)
        }
        
        nameTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(avatar.snp.right).offset(10)
        }
        
        onlineTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(5)
            make.left.equalTo(nameTitle.snp.left)
        }
        
        onlineIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(6)
        }
        
        springyViewFirst.snp.makeConstraints { make in
            make.centerY.equalTo(avatar.snp.centerY)
            make.left.equalTo(nameTitle.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(20)
        }
        
        springyViewSecond.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        springyLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.width.equalTo(15)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImage.snp.centerY)
            make.left.equalTo(locationImage.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        avatar.layer.cornerRadius = avatar.layer.frame.height / 2
        springyViewFirst.layer.cornerRadius = springyViewFirst.layer.frame.height / 2
        springyViewSecond.layer.cornerRadius = springyViewSecond.layer.frame.height / 2
        onlineIndicator.layer.cornerRadius = onlineIndicator.layer.frame.height / 2
    }
   
}
