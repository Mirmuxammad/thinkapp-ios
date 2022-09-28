//
//  MainMapView.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit
import GoogleMaps
import SnapKit

class MainMapView: UIView {
    
    var mapView: GMSMapView = {
        var map = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: 37.6173, longitude: 55.7558, zoom: 10.0)
        map = GMSMapView.map(withFrame: .zero, camera: camera)
        return map
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
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "refreshButton"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.25
        return button
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = UIColor(hex: "#545454")
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.25
        return button
    }()
    
    private let addMarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "addMarkButton"), for: .normal)
        button.backgroundColor = UIColor(hex: "#FD698D")
        button.layer.cornerRadius = 22.5
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.58
        button.layer.shadowColor = UIColor(hex: "#FD698D").cgColor
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        addConstraints()
    }
    
    func addMarkAddTarget(target: Any, action: Selector) {
        addMarkButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func backAddTarget(target: Any, action: Selector) {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func filtersAddTarget(target: Any, action: Selector) {
        filterButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func addViews() {
        addSubview(mapView)
        addSubview(backButton)
        addSubview(refreshButton)
        addSubview(filterButton)
        addSubview(addMarkButton)
    }
    
    private func addConstraints() {
        
        backButton.isHidden = true
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(63)
            make.left.equalToSuperview().offset(54)
            make.height.width.equalTo(30)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(63)
            make.right.equalToSuperview().offset(-58)
            make.height.width.equalTo(30)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(63)
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(30)
        }
        
        addMarkButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(45)
        }
    }
}
