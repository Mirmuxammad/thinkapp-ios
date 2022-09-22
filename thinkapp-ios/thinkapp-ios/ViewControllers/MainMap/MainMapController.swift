//
//  MainMapController.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit
import GoogleMaps

class MainMapController: UIViewController, Routable {
    
    var router: MainRouter?
    
    var mapMarks: [MapMarkResponce] = []
    
    private let customMarker: CustomAnnotationView = CustomAnnotationView()
    
    private let baseView: MainMapView = MainMapView()
    
    private let locationManager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.backAddTarget(target: self, action: #selector(back))
        baseView.filtersAddTarget(target: self, action: #selector(getFilters))
        baseView.addMarkAddTarget(target: self, action: #selector(addMark))
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = baseView.mapView
        baseView.mapView.delegate = self
        baseView.mapView.isMyLocationEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillLayoutSubviews()
        getMapMarks()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        baseView.frame = view.bounds
        view.addSubview(baseView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    @objc private func getFilters() {
        router?.pushFilters()
    }
    
    @objc private func back() {
        router?.back()
    }
    
    @objc private func addMark() {
        router?.pushAddMark()
    }
    
    private func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            checkAuthLoc()
//            setupTileRenderer()
        } else {
            showAlertLocation(title: "Your geolocation service is disabled", message: "Do you want to turn it on?", UrlString: "App-Prefs:root=LOCATION_SERVICES")
        }
    }
    
    private func checkAuthLoc() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            showAlertLocation(title: "You have denied access to the location", message: "Do you want to open access?", UrlString: UIApplication.openSettingsURLString)
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            //baseView.mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
    
    private func showMark() {
        for location in mapMarks {
            let marker = GMSMarker()
            marker.iconView = customMarker
        }
    }
    
    private func setupTileRenderer() {
        let template = "https://api.maptiler.com/maps/basic-4326/{z}/{x}/{y}.png"
        let overlay = AdventureMapOverlay(urlTemplate: template)
        
        overlay.canReplaceMapContent = true
       // baseView.mapView.addOverlay(overlay, level: .aboveLabels)
    }
    
    private func showAlertLocation(title: String, message: String, UrlString: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in
            if let url = URL(string: UrlString) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func getMapMarks() {
        baseView.activityIndicator.startAnimating()
        MapAPI.getMapMarker { [weak self] jsonData in
            self?.mapMarks = jsonData
            self?.baseView.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MainMapController: GMSMapViewDelegate {
    
}
