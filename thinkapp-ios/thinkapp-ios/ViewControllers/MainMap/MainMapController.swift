//
//  MainMapController.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit
import GoogleMaps
import GooglePlaces


class MainMapController: UIViewController, Routable {
    
    var router: MainRouter?
    
    var mapMarks: [MapMarkResponce] = []
    var searchMarks: [MapMarkResponce] = []
    var usrLat : Double = 0
    var usrLng : Double = 0
    var gender : String?
    var ageFrom: Double?
    var ageTo: Double?
    var maxDistance: Double = 100
    private let customMarker: CustomAnnotationView = CustomAnnotationView()
    private let baseView: MainMapView = MainMapView()
    private let locationManager = CLLocationManager()
    
    private var showMarker: Bool = true
    
    init(gender: String? = nil,
         ageFrom: Double? = nil,
         ageTo: Double? = nil,
         maxDistance: Double = 100) {
        self.gender = gender
        self.ageFrom = ageFrom
        self.ageTo = ageTo
        self.maxDistance = maxDistance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.backAddTarget(target: self, action: #selector(back))
        baseView.filtersAddTarget(target: self, action: #selector(getFilters))
        baseView.addMarkAddTarget(target: self, action: #selector(addMark))
        baseView.refreshAddTarget(target: self, action: #selector(refreshBtn))
        
        baseView.mapView.delegate = self
        baseView.mapView.isMyLocationEnabled = true
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //getMapMarks()
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
    
    @objc private func refreshBtn() {
//        self.getMapMarks()
        self.baseView.mapView.clear()
        self.searchMapMarks(gender: nil, ageFrom: 0, ageTo: 100, maxDistance: 100)
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
        //baseView.activityIndicator.startAnimating()
        MapAPI.getMapMarker { [weak self] jsonData in
            self?.mapMarks = jsonData
            self?.showCurrentLocationOnMap()
            self?.searchMapMarks(gender: self?.gender, ageFrom: self?.ageFrom, ageTo: self?.ageFrom, maxDistance: self?.maxDistance)
          //  self?.baseView.activityIndicator.stopAnimating()
        } failure: { error in
            let alert = UIAlertController(title: "Ошибка", message: error?.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func addsearchPlaceMarkers() {
        var coordintates: [CLLocationCoordinate2D] = []
        for i in searchMarks {
            let lat = i.location.lat
            let lon = i.location.lon
            coordintates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
        for coordintate in coordintates {
            let customMark = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 53, height: 90))
            customMark.layer.cornerRadius = 5
            customMark.backgroundColor = .white
            let marker = GMSMarker()
            marker.position = coordintate
            marker.map = baseView.mapView
            customMark.contenerViwe.layer.cornerRadius = 5
            marker.iconView = customMark
        }
    }
    
    func showCurrentLocationOnMap() {
        baseView.mapView.settings.myLocationButton = true
        baseView.mapView.isMyLocationEnabled = true
        for data in mapMarks {
            let customMark = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 53, height: 90))
            customMark.layer.cornerRadius = 5
            customMark.backgroundColor = .white
            customMark.mapMark = data
            
            let location = CLLocationCoordinate2D(latitude: data.location.lat, longitude: data.location.lon)
            
            let marker = GMSMarker()
            marker.position = location
            
            marker.iconView = customMark
            marker.map = baseView.mapView
            
        }
        //addPlaceMarkers()
    }
    
//    private func addPlaceMarkers() {
//        let coordintates: [CLLocationCoordinate2D] = [
//            CLLocationCoordinate2D(latitude: 37.6173, longitude: 55.7558),
//            CLLocationCoordinate2D(latitude: 37.6173, longitude: 56.7558),
//            CLLocationCoordinate2D(latitude: 37.6173, longitude: 57.7558)
//        ]
//
//        for coordintate in coordintates {
//            let customMark = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 53, height: 90))
//            customMark.layer.cornerRadius = 5
//            customMark.backgroundColor = .white
//            let marker = GMSMarker()
//            marker.position = coordintate
//            marker.map = baseView.mapView
//            customMark.contenerViwe.layer.cornerRadius = 5
//            marker.iconView = customMark
//        }
//    }
    
    private func searchMapMarks(gender: String?, ageFrom: Double?, ageTo: Double?, maxDistance: Double?) {
        MapAPI.searchMarks(location: Location(lat: self.usrLat, lon: self.usrLng), gender: gender, ageFrom: ageFrom, ageMin: ageTo, maxDisatance: maxDistance ?? 0) { data in
            self.searchMarks = data
            self.addsearchPlaceMarkers()
        } failture: { eror in
            debugPrint("searchMapMarks failed!!!")
            print(eror)
        }
    }
}

extension MainMapController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let markerInfoView = CustomAnnotationView(frame: CGRect(x: 0, y: 0, width: 157, height: 195))
        let markerInfoViewNotText = CustomAnnotationView(frame: CGRect(x: 0, y: 0, width: 157, height: 100))
        let markerInfo = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 53, height: 90))
        if showMarker == true {
            UIView.animate(withDuration: 1) {
                if markerInfo.mapMark?.text == "" {
                    markerInfoView.addConstraints()
                    markerInfo.mapMark = markerInfoView.markInfo
                    marker.iconView = markerInfo
                } else {
                    markerInfoViewNotText.addConstraintsNotText()
                    markerInfo.mapMark = markerInfoViewNotText.markInfo
                    marker.iconView = markerInfoViewNotText
                }
            }
        } else {
            UIView.animate(withDuration: 1) {
                markerInfoView.markInfo = markerInfo.mapMark
                marker.iconView = markerInfo
                marker.iconView?.backgroundColor = .white
            }
        }
        showMarker = !showMarker
        return true
    }
    
    func mapView( _ mapView: GMSMapView, markerInfoContents marker: GMSMarker ) -> UIView? {
       let infoView = CustomAnnotationView(frame: CGRect(x: 0, y: 0, width: 157, height: 195))
        return infoView
    }
    
}

extension MainMapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            usrLat = location.latitude
            usrLng = location.longitude
            
            UserDefaultsService.sharedInstance.userLat = location.latitude
            UserDefaultsService.sharedInstance.userLat = location.longitude
            
            let camera = GMSCameraPosition.camera(withLatitude: usrLat, longitude: usrLng, zoom: 10.0)
            self.baseView.mapView.camera = camera
        }
        self.getMapMarks()
        //self.showCurrentLocationOnMap()
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
}

