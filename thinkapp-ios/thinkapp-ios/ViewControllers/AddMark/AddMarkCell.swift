//
//  MapViewCell.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 11.09.2022.
//

import UIKit
import SnapKit
import MapKit

class AddMarkCell: UITableViewCell {
    
    static let identifier = "AddMarkCell"
    var genderBtnDelegate : AddMarkCellDelegate!
    // MARK: - Private Properties
    let mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 57
        map.showsUserLocation = true
        return map
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "plusButton"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.backgroundColor = .clear
        return button
    }()
    
    private let genderPreferenceLabel: UILabel = {
        let label = UILabel()
        label.text = "You Gender"
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textColor = UIColor(hex: "000000", alpha: 0.62)
        label.textAlignment = .left
        return label
    }()
    
    let genderPreferenceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 15)
        button.setTitleColor(UIColor(hex: "000000"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(genderBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let genderPreferenceVectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightVector")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        separatorInset.left = 0
    }
    
    private func addViews() {
        contentView.addSubview(mapView)
        contentView.addSubview(plusButton)
        contentView.addSubview(genderPreferenceLabel)
        contentView.addSubview(genderPreferenceButton)
        contentView.addSubview(genderPreferenceVectorImageView)
    }
    
    private func addConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
            make.height.equalTo(mapView.snp.width).multipliedBy(CGFloat(350)/CGFloat(384))
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerX.equalTo(mapView.snp.centerX)
            make.centerY.equalTo(mapView.snp.bottom).offset(3)
            make.width.equalTo(95)
        }
        
        genderPreferenceLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(58)
            make.left.equalToSuperview().offset(35)
            make.width.equalTo(136)
            make.height.equalTo(18)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        genderPreferenceButton.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(58)
            make.right.equalToSuperview().offset(-51)
            make.height.equalTo(18)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        genderPreferenceVectorImageView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(57)
            make.right.equalToSuperview().offset(-26)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    @objc func genderBtnTapped() {
        genderBtnDelegate?.didGenderBtnTapped()
    }
    
    // MARK: - Public Methods
    func plusAddTarget(target: Any, action: Selector) {
        plusButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

//MARK: - AddMarkCellDelegate
protocol AddMarkCellDelegate {
    func didGenderBtnTapped()
}
