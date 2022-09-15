//
//  DoneButtonCell.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit
import SnapKit

class DoneButtonCell: UITableViewCell {
        
    static let identifier = "DoneButtonCell"
    
    // MARK: - Private Properties
    let doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 28)
        button.setTitleColor(UIColor(hex: "FFFBFB"), for: .normal)
        button.setBackgroundImage(UIImage(named: "doneButton"), for: .normal)
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
        contentView.addSubview(doneButton)
    }
    
    private func addConstraints() {
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(166)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-19)
        }
    }
    
    // MARK: - Public Methods
    func doneAddTarget(target: Any, action: Selector) {
        doneButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
