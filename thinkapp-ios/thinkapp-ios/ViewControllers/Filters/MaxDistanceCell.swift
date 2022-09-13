//
//  MaxDistanceCell.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit
import SnapKit
import RangeUISlider

class MaxDistanceCell: UITableViewCell {
    
    static let identifier = "MaxDistanceCell"
    
    // MARK: - Private Properties
    private let maxDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Maximum Distance"
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textColor = UIColor(hex: "000000", alpha: 0.62)
        label.textAlignment = .left
        return label
    }()
    
    let maxDistanceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("40-100 Km", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 15)
        button.setTitleColor(UIColor(hex: "000000"), for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private let maxDistanceVectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "topVector")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let maxDistanceSlider: RangeUISlider = {
        let rangeSlider = RangeUISlider()
        rangeSlider.accessibilityIdentifier = "maxDistanceSlider"
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.stepIncrement = 1
        
        rangeSlider.defaultValueLeftKnob = 40
        rangeSlider.defaultValueRightKnob = 100
        
        rangeSlider.scaleMinValue = 0
        rangeSlider.scaleMaxValue = 250
        
        rangeSlider.rangeSelectedColor = .clear
        rangeSlider.rangeSelectedBackgroundImage = UIImage(named: "rangeSelected")
        
        rangeSlider.rangeNotSelectedColor = .clear
        rangeSlider.rangeNotSelectedBackgroundImage = UIImage(named: "rangeNotSelected")
        
        rangeSlider.leftKnobWidth = 17
        rangeSlider.leftKnobHeight = 17
        rangeSlider.leftKnobImage = UIImage(named: "knob")
        
        rangeSlider.rightKnobWidth = 17
        rangeSlider.rightKnobHeight = 17
        rangeSlider.rightKnobImage = UIImage(named: "knob")
        
        rangeSlider.barHeight = 5
        rangeSlider.barLeading = 0
        rangeSlider.barTrailing = 0
        
        return rangeSlider
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
        contentView.addSubview(maxDistanceLabel)
        contentView.addSubview(maxDistanceButton)
        contentView.addSubview(maxDistanceVectorImageView)
        contentView.addSubview(maxDistanceSlider)
    }
    
    private func addConstraints() {
        maxDistanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.left.equalToSuperview().offset(35)
            make.width.equalTo(137)
            make.height.equalTo(18)
            make.bottom.equalTo(maxDistanceSlider.snp.top).offset(-26)
        }
        
        maxDistanceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.right.equalToSuperview().offset(-51)
            make.height.equalTo(18)
            make.bottom.equalTo(maxDistanceSlider.snp.top).offset(-26)
        }
        
        maxDistanceVectorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-26)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalTo(maxDistanceSlider.snp.top).offset(-25)
        }
        
        maxDistanceSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-28)
            make.height.equalTo(17)
            make.bottom.equalToSuperview().offset(-29)
        }
    }    
}
