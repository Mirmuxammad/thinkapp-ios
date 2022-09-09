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
    private let doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 15)
        button.setTitleColor(UIColor(hex: "FFFBFB"), for: .normal)
        button.setBackgroundImage(UIImage(named: "doneButton"), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addConstraints()
        configureCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureCell() {
        separatorInset.left = 500
    }
    
    private func addViews() {
        addSubview(doneButton)
    }
    
    private func addConstraints() {
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    func doneAddTarget(_ sender: UIButton) {
        doneButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc private func back() {
        print("Done")
    }    
}
