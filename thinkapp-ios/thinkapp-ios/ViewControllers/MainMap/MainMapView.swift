//
//  MainMapView.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit
import MapKit
import SnapKit

class MainMapView: UIView {

    let mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        addConstraints()
    }
    
    func backAddTarger(target: Any, action: Selector) {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func mapDelegate(delegate: MKMapViewDelegate) {
        mapView.delegate = delegate
    } 
    
    private func addViews() {
        addSubview(mapView)
        addSubview(backButton)
    }
    
    private func addConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(54)
            make.height.width.equalTo(30)
        }
    }
    
    


}
