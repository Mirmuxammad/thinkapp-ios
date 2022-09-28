//
//  MyMessageCell.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 12.09.2022.
//

import UIKit
import SnapKit

class MyMessageCell: UITableViewCell {
    
    static let identifier = "MyMessageCell"
    var doneDelegate: MyMessageCellDelegate!
    // MARK: - Private Properties
    let myMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "My Message"
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textColor = UIColor(hex: "000000", alpha: 0.62)
        label.textAlignment = .left
        return label
    }()
    
    private let myMessageFieldImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "messageField")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let myMessageTextView: UITextView = {
        let textView = UITextView()
        textView.accessibilityIdentifier = "myMessageTextView"
        textView.text = "Write A Message here"
        textView.font = UIFont(name: "Inter-Medium", size: 15)
        textView.textColor = UIColor(hex: "000000", alpha: 0.62)
        textView.textAlignment = .left
        textView.autocorrectionType = .no
        return textView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        addViews()
        addConstraints()
        toolBarSetup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureCell() {
        separatorInset.left = .infinity
    }
    
    private func addViews() {
        contentView.addSubview(myMessageLabel)
        contentView.addSubview(myMessageFieldImageView)
        contentView.addSubview(myMessageTextView)
    }
    
    func toolBarSetup() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard));
        toolBar.setItems([cancelButton, spaceButton, button], animated: true)
        toolBar.isUserInteractionEnabled = true

        myMessageTextView.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        doneDelegate?.didDoneTapped()
    }
    
    private func addConstraints() {
        myMessageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(22)
            make.width.equalTo(91)
            make.height.equalTo(18)
        }
        
        myMessageFieldImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(81)
            make.left.equalToSuperview().offset(26)
            make.right.equalTo(-29)
            make.height.equalTo(104)
            make.bottom.equalToSuperview().offset(-31)
        }
        
        myMessageTextView.snp.makeConstraints { make in
            make.top.equalTo(myMessageFieldImageView).offset(20)
            make.left.equalTo(myMessageFieldImageView.snp.left).offset(23)
            make.right.equalTo(myMessageFieldImageView.snp.right).offset(-23)
            make.bottom.equalTo(myMessageFieldImageView.snp.bottom).offset(-24)
        }
    }
}

//MARK: MyMessageCellDelegate toolbar btns tapped
protocol MyMessageCellDelegate {
    func didDoneTapped()
}
