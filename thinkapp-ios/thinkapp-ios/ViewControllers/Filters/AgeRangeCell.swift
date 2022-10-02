//
//  AgeRangeCell.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit
import SnapKit
import RangeUISlider

class AgeRangeCell: UITableViewCell {
    
    static let identifier = "AgeRangeCell"
    
    // MARK: - Private Properties
    let ageRangeTitle: UILabel = {
        let label = UILabel()
        label.text = "Age Range"
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textColor = UIColor(hex: "000000", alpha: 0.62)
        label.textAlignment = .left
        return label
    }()
    
    let rangeLabel: UILabel = {
        let label = UILabel()
        label.text = "25-32 Age"
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textAlignment = .right
        label.textColor = UIColor(hex: "000000")
        return label
    }()
    
    lazy var ageRangeSlider: RangeUISlider = {
        let rangeSlider = RangeUISlider()
        rangeSlider.accessibilityIdentifier = "ageRangeSlider"
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.stepIncrement = 1
        
        rangeSlider.defaultValueLeftKnob = 25
        rangeSlider.defaultValueRightKnob = 32
        
        rangeSlider.scaleMinValue = 18
        rangeSlider.scaleMaxValue = 100
        
        rangeSlider.rangeSelectedColor = .clear
        rangeSlider.rangeSelectedBackgroundImage = UIImage(named: "rangeSelected")
        
        rangeSlider.rangeNotSelectedColor = .clear
        rangeSlider.rangeNotSelectedBackgroundImage = UIImage(named: "rangeNotSelected")
        
        rangeSlider.leftKnobWidth = 17
        rangeSlider.leftKnobHeight = 17
        rangeSlider.leftKnobImage = nil//UIImage(named: "knob")
        
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
        contentView.addSubview(ageRangeTitle)
        contentView.addSubview(rangeLabel)
        contentView.addSubview(ageRangeSlider)
    }
    
    private func addConstraints() {
        ageRangeTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.left.equalToSuperview().offset(35)
            make.width.equalTo(78)
            make.height.equalTo(18)
            make.bottom.equalTo(ageRangeSlider.snp.top).offset(-27)
        }
        
        rangeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.right.equalToSuperview().offset(-26)
            make.height.equalTo(18)
            make.bottom.equalTo(ageRangeSlider.snp.top).offset(-27)
        }
        
        ageRangeSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-28)
            make.height.equalTo(17)
            make.bottom.equalToSuperview().offset(-28)
        }
    }    
}
