//
//  BackButtonCell.swift
//  thinkapp-ios
//
//  Created by user1 on 23/09/22.
//

import SnapKit
import UIKit

class BackButtonCell: UITableViewCell {
    
    static let identifier = "BackButtonCell"
    
    // MARK: - Private Properties
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
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        addViews()
        addConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureCell() {
        separatorInset.left = .infinity
    }
    
    private func addViews() {
        contentView.addSubview(backButton)
    }
    
    private func addConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
    }
    
    // MARK: - Public Methods
    func backAddTarget(target: Any, action: Selector) {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
