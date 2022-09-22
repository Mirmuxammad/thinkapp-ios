//
//  CustomAnnotationView.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 19/09/22.
//

import UIKit
import MapKit

class CustomAnnotationView: UIView {
    
    let contenerViwe: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        img.image = UIImage(systemName: "person")
       return img
    }()
    
    let nameTitle: UILabel = {
        let label = UILabel()
        label.text = "eva trost"
        label.font = BaseFont.syneRegular(with: 16)
        label.textAlignment = .center
        label.text?.suffix(1).uppercased()
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
        label.font = BaseFont.syneBolt(with: 12)
        label.textColor = .white
        return label
    }()
    
    let textLabel: UILabel = {
       let label = UILabel()
        label.text = "Я бегать в 14 00, кто со мной?"
        label.font = BaseFont.syneRegular(with: 15)
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
        addViews()
        addConstraints()
    }
 
    private func addViews() {
        addSubview(contenerViwe)
        contenerViwe.addSubview(containerStackView)
        containerStackView.addSubview(nameTitle)
        containerStackView.addSubview(avatar)
        avatar.addSubview(onlineIndicator)
        containerStackView.addSubview(springyViewFirst)
        springyViewFirst.addSubview(springyViewSecond)
        springyViewSecond.addSubview(springyLable)
        containerStackView.addSubview(textLabel)
        containerStackView.addSubview(locationImage)
        containerStackView.addSubview(locationLabel)
    }
    
    private func addConstraints() {
        
        contenerViwe.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.left.bottom.right.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        avatar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.height.width.equalTo(42)
        }
        
        nameTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(avatar.snp.right).offset(5)
        }
        
        onlineIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(6)
        }
        
        springyViewFirst.snp.makeConstraints { make in
            make.centerY.equalTo(avatar.snp.centerY)
            make.left.equalTo(nameTitle.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
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
            make.bottom.equalToSuperview().offset(-5)
            make.height.width.equalTo(15)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImage.snp.centerY)
            make.left.equalTo(locationImage.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        avatar.layer.cornerRadius = avatar.layer.frame.height / 2
        springyViewFirst.layer.cornerRadius = springyViewFirst.layer.frame.height / 2
        springyViewSecond.layer.cornerRadius = springyViewSecond.layer.frame.height / 2
        onlineIndicator.layer.cornerRadius = onlineIndicator.layer.frame.height / 2
        
    }
}
