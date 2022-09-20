//
//  MainMapController.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit
import MapKit

class MainMapController: UIViewController, Routable {
    
    var router: MainRouter?
    
    var mapMarks: [MapMarkResponce] = []
    
    
    private let baseView: MainMapView = MainMapView()
    
    private let locationManager = CLLocationManager()
    
    private var tileRenderer: MKTileOverlayRenderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.backAddTarget(target: self, action: #selector(back))
        baseView.filtersAddTarget(target: self, action: #selector(getFilters))
        baseView.addMarkAddTarget(target: self, action: #selector(addMark))
        baseView.mapDelegate(delegate: self)
        creatAnnotation(locations: mapMarks)
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
            setupLocManager()
            checkAuthLoc()
//            setupTileRenderer()
        } else {
            showAlertLocation(title: "Your geolocation service is disabled", message: "Do you want to turn it on?", UrlString: "App-Prefs:root=LOCATION_SERVICES")
        }
    }

    private func setupLocManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
            baseView.mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
    
    private func setupTileRenderer() {
        let template = "https://api.maptiler.com/maps/basic-4326/{z}/{x}/{y}.png"
        let overlay = AdventureMapOverlay(urlTemplate: template)
        
        overlay.canReplaceMapContent = true
        baseView.mapView.addOverlay(overlay, level: .aboveLabels)
        tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
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
            self?.creatAnnotation(locations: self!.mapMarks)
            self?.baseView.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func creatAnnotation(locations: [MapMarkResponce]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location.text
            annotations.subtitle = "User Name"
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.location.lat as! CLLocationDegrees, longitude: location.location.lon as! CLLocationDegrees)
            baseView.mapView.addAnnotation(annotations)
        }
        
        
    }

}

extension MainMapController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        
        var annotationView = baseView.mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "map_arrow")
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileRenderer = tileRenderer else { return MKOverlayRenderer()}
        return tileRenderer
    }
    
    
    
    
}

extension MainMapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            let myAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = location
            baseView.mapView.setRegion(region, animated: true)
            baseView.mapView.removeAnnotations(baseView.mapView.annotations)
            baseView.mapView.addAnnotation(myAnnotation)
            locationManager.stopUpdatingLocation()
        }
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthLoc()
    }
}
