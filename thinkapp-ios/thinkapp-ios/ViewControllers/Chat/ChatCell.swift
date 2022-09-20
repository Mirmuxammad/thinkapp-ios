//
//  ChatCell.swift
//  thinkapp-ios
//
//  Created by Mavlon on 20/09/22.
//

import UIKit

class ChatCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "ChatCell"
    
    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner]
        view.backgroundColor = UIColor(hex: "#F0F0F0")
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ava")
        imageView.layer.cornerRadius =  17.5
        return imageView
    }()
    
    private let chatLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey,Girl wanna go for a run together?"
        label.font = BaseFont.interRegulat(with: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.interMedium(with: 10)
        label.text = "9:25 Am"
        label.textColor = UIColor(hex: "#000000", alpha: 0.24)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupCell(with message: Message) {
//        chatLabel.text = message.message
//        dateLabel.text = message.created_at.getFormattedDateForChat()
//    }
    
        
    // MARK: - Private functions
    
    private func setupViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(dateLabel)
        containerView.addSubview(chatLabel)
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top).offset(-8)
            make.left.equalToSuperview()
            make.height.width.equalTo(35)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(logoImageView.snp.right).offset(6)
            make.bottom.equalTo(dateLabel.snp.top).offset(-4)
            make.right.equalToSuperview().offset(-50)
//            make.height.equalTo(100)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(6)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(22)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        
    }

}
