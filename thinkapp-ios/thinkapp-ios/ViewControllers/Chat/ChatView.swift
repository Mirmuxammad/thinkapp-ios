//
//  ChatView.swift
//  thinkapp-ios
//
//  Created by Mavlon on 16/09/22.
//

import UIKit
import SnapKit

class ChatView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.25
        return button
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ava")
        imageView.layer.cornerRadius = 21
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.interMedium(with: 15)//syneBolt(with: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Gina Ostermann"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.interMedium(with: 10)//syneBolt(with: 10)
        label.textColor = UIColor(hex: "#978F8F", alpha: 0.66)
        label.textAlignment = .center
        label.text = "Online"
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F5F5F5", alpha: 0.45)
        return view
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#000000", alpha: 0.19).cgColor
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let attachmentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "type message here"
        textView.font = BaseFont.interMedium(with: 11)
        return textView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#7C7C7C", alpha: 0.75)
        return view
    }()
    
    private let audioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "microphone"), for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
        addConstraints()
    }
    
    func backAddTarget(target: Any, action: Selector) {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func addViews() {
        textView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        addSubview(navigationView)
        navigationView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(backButton)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(avatarImageView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(statusLabel)
        addSubview(textContainerView)
        textContainerView.addSubview(attachmentButton)
        textContainerView.addSubview(lineView)
        textContainerView.addSubview(textView)
        textContainerView.addSubview(audioButton)
    }
    
    private func addConstraints() {
        
        navigationView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(42)
        }

        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(42)
        }
        
        textContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        attachmentButton.snp.makeConstraints { make in
            make.width.height.equalTo(21)
            make.left.equalToSuperview().offset(17)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(attachmentButton.snp.right).offset(15)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(11)
            make.height.equalTo(52)
            make.top.bottom.equalToSuperview()
        }
        
        audioButton.snp.makeConstraints { make in
            make.width.height.equalTo(23)
            make.left.equalTo(textView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
}
