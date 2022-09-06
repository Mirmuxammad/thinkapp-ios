//
//  AddMarkController.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 06.09.2022.
//

import UIKit
import MapKit

class AddMarkController: UITableViewController, Routable {

    @IBOutlet var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    var router: MainRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        mapDelegate(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func setupMapView() {
        mapView.layer.cornerRadius = 57
    }
    
    func mapDelegate(delegate: MKMapViewDelegate) {
        mapView.delegate = delegate
    }
    
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAutorization()
        } else {
            showAlertLocation(title: "Your geolocation service is disabled",
                              message: "Do you want to turn it on?",
                              url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied:
            showAlertLocation(title: "You have denied access to the location",
                              message: "Do you want to open access?",
                              url: URL(string: UIApplication.openSettingsURLString))
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func showAlertLocation(title: String, message: String?, url: URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { alert in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
 
    @IBAction func pressAddMarkButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension AddMarkController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "location")
        
        return annotationView
    }
}

extension AddMarkController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            let myAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = location
            mapView.setRegion(region, animated: true)
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(myAnnotation)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAutorization()
    }
}
