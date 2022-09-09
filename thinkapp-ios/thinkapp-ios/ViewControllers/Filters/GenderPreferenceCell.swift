//
//  GenderPreferenceCell.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit
import SnapKit

class GenderPreferenceCell: UITableViewCell {
    
    static let identifier = "GenderPreferenceCell"
    
    // MARK: - Private Properties
    private let genderPreferenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender Preference"
        label.font = UIFont(name: "Inter-Regular", size: 15)
        label.textColor = UIColor(hex: "000000", alpha: 0.62)
        label.textAlignment = .left
        return label
    }()
    
    private let genderPreferenceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 15)
        button.setTitleColor(UIColor(hex: "000000"), for: .normal)
        return button
    }()
    
    private let rightVectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightVector")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addViews() {
        addSubview(genderPreferenceLabel)
        addSubview(genderPreferenceButton)
        addSubview(rightVectorImageView)
    }
    
    private func addConstraints() {
        genderPreferenceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.left.equalToSuperview().offset(35)
        }
        
        genderPreferenceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.right.equalToSuperview().offset(-51)
            make.height.equalTo(18)
        }
        
        rightVectorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-32)
        }
    }
}
