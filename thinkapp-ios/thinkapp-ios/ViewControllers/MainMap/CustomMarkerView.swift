//
//  CustomMarkerView.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 26/09/22.
//

import Foundation
import UIKit
import GoogleMaps

class CustomMarkerView: UIView{
    
    var mapMark: MapMarkResponce?
    
    
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
    
    let onlineTitle: UILabel = {
       let label = UILabel()
        label.text = "online"
        label.textColor = .gray
        label.font = label.font.withSize(10)
        return label
    }()
    
    let locationImage: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "location")
        img.tintColor = UIColor(hex: "#978F8F")
        return img
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            addViews()
            addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addViews() {
        addSubview(contenerViwe)
        contenerViwe.addSubview(avatar)
        contenerViwe.addSubview(locationImage)
        contenerViwe.addSubview(onlineTitle)
        avatar.addSubview(onlineIndicator)
    }
    
    private func addConstraints() {
        
        contenerViwe.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        onlineTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        avatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onlineTitle.snp.bottom).offset(5)
            make.height.width.equalTo(42)
        }
        
        onlineIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(6)
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.width.equalTo(15)
        }
       
        contenerViwe.layer.cornerRadius = 5
        avatar.layer.cornerRadius = avatar.layer.frame.height / 2
        onlineIndicator.layer.cornerRadius = onlineIndicator.layer.frame.height / 2
    }
    
    
}

