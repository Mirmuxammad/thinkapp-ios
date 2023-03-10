//
//  AddMarkViewController.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 11.09.2022.
//

import UIKit
import MapKit
import RangeUISlider
import CoreLocation

class AddMarkViewController: UIViewController, Routable {
    
    // MARK: - Private Properties
    private let table: AddMarkTableView = AddMarkTableView()
    private var dataSourceArray = [AddMarkCellType]()
    private let massageView: MyMessageCell = MyMessageCell()
    private let addMarkCell: AddMarkCell = AddMarkCell()
    private let ageRange: AgeRangeCell = AgeRangeCell()
    
    private var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    
    private weak var maxDistanceButton: UIButton?
    private weak var ageRangeButton: UIButton?
    
    var location: Location?
    
    
    // MARK: - Public Properties
    var router: MainRouter?
    var userGender : Gender = .female
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        dataSourceArray = [.BackButton, .AddMark, .MaxDistance, .AgeRange, .MyMessage]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        conformProtocols()
        settingUpTextFieldEditing()
        listenerTextFieldNotification()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        table.frame = view.bounds
        view.addSubview(table)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    // MARK: - Private Methods
    private func registerCells() {
        table.tableView.register(BackButtonCell.self, forCellReuseIdentifier: BackButtonCell.identifier)
        table.tableView.register(AddMarkCell.self, forCellReuseIdentifier: AddMarkCell.identifier)
        table.tableView.register(MaxDistanceCell.self, forCellReuseIdentifier: MaxDistanceCell.identifier)
        table.tableView.register(AgeRangeCell.self, forCellReuseIdentifier: AgeRangeCell.identifier)
        table.tableView.register(MyMessageCell.self, forCellReuseIdentifier: MyMessageCell.identifier)
    }
    
    private func conformProtocols() {
        table.tableView.delegate = self
        table.tableView.dataSource = self
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
}

// MARK: - UITableViewDataSource
extension AddMarkViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = dataSourceArray[indexPath.row]
        switch typeCell {
        case .BackButton:
            let backBtnCell = tableView.dequeueReusableCell(withIdentifier: BackButtonCell.identifier,
                                                                    for: indexPath) as!  BackButtonCell
            backBtnCell.backAddTarget(target: self, action: #selector(backButton))
            return backBtnCell
        case .AddMark:
            let addMarkCell = tableView.dequeueReusableCell(withIdentifier: AddMarkCell.identifier,
                                                                     for: indexPath) as! AddMarkCell
            addMarkCell.mapView.delegate = self
            mapView = addMarkCell.mapView
            addMarkCell.genderBtnDelegate = self
            addMarkCell.genderPreferenceButton.setTitle(userGender.title, for: .normal)
            addMarkCell.plusAddTarget(target: self, action: #selector(back))
            return addMarkCell
        
        case .MaxDistance:
            let maxDistanceCell = tableView.dequeueReusableCell(withIdentifier: MaxDistanceCell.identifier,
                                                                for: indexPath) as! MaxDistanceCell
            maxDistanceCell.maxDistanceSlider.delegate = self
            //maxDistanceButton = maxDistanceCell.maxDistanceButton
            return maxDistanceCell
        
        case .AgeRange:
            let ageRangeCell = tableView.dequeueReusableCell(withIdentifier: AgeRangeCell.identifier,
                                                             for: indexPath) as! AgeRangeCell
            ageRangeCell.ageRangeSlider.delegate = self
            //ageRangeButton = ageRangeCell.ageRangeButton
            //ageRangeCell.ageRangeLabel.text = "You Age"
            ageRangeCell.ageRangeSlider.defaultValueLeftKnob = 0
            ageRangeCell.ageRangeSlider.scaleMinValue = 0
//            ageRangeCell.ageRangeSlider.leftKnobImage = nil
            return ageRangeCell
            
        case .MyMessage:
            let myMessageCell = tableView.dequeueReusableCell(withIdentifier: MyMessageCell.identifier,
                                                             for: indexPath) as! MyMessageCell
            myMessageCell.doneDelegate = self
            myMessageCell.myMessageTextView.delegate = self
            return myMessageCell
        }
    }
    
    @objc private func back() {
        let lon = Double(mapView.centerCoordinate.longitude.debugDescription) ?? 0.0
        let lat = Double(mapView.centerCoordinate.latitude.debugDescription) ??  0.0
        guard let age = ageRangeButton?.titleLabel?.text?.prefix(2) else {return}
        guard let gender = addMarkCell.genderPreferenceButton.titleLabel?.text?.lowercased() else { return }
        guard let text = massageView.myMessageLabel.text else { return }
        print("????")
        print(gender)
        MapAPI.postMapMark(location: Location(lat: lat, lon: lon), gender: gender, age: String(age), text: text, success: { [weak self] jsonData in
            
        }) { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
        
        print("back")
        print(mapView.centerCoordinate.longitude.debugDescription)
        router?.back()
    }
    
    @objc private func backButton() {
        router?.back()
    }
}

// MARK: - UITableViewDelegate
extension AddMarkViewController: UITableViewDelegate {
}

// MARK: - MKMapViewDelegate
extension AddMarkViewController: MKMapViewDelegate {
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

// MARK: - CLLocationManagerDelegate
extension AddMarkViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            let myAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = location
            mapView?.setRegion(region, animated: true)
            mapView.removeAnnotations(mapView!.annotations)
            mapView?.addAnnotation(myAnnotation)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAutorization()
    }
}

// MARK: - RangeUISliderDelegate
extension AddMarkViewController: RangeUISliderDelegate {
    func rangeChangeFinished(event: RangeUISliderChangeFinishedEvent) {
        
    }
    
    
    func rangeChangeFinished(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
    
    }
    
    func rangeIsChanging(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
        switch slider.accessibilityIdentifier {
        case "maxDistanceSlider":
            maxDistanceButton?.setTitle("\(Int(minValueSelected))-\(Int(maxValueSelected)) Km", for: .normal)
        case "ageRangeSlider":
            ageRangeButton?.setTitle(/*\(Int(event.minValueSelected))-*/"\(Int(maxValueSelected)) Age", for: .normal)
        default:
            break
        }
    }
}

// MARK: - UITextViewDelegate
extension AddMarkViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.accessibilityIdentifier {
        case "myMessageTextView":
            textView.text = ""
            textView.textColor = UIColor.black
        default:
            break
        }
    }
    
    ///add tap gesture in view for removing keyboar when textfild editing
    private func settingUpTextFieldEditing() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    //Key board hide on outside the textfield
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    ///this func showed keybord when user touched textfield or textview
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let h = keyboardSize.height - (self.view.frame.maxY - table.tableView.frame.maxY)
         
            if h > 0 {
                self.table.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                scrollToBottom()
            }
        }
    }
    
    ///this func wil lhide keybord when user touched textfield or textview
    @objc func keyboardWillHide(notification: NSNotification) {
        self.table.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    ///scroll to bottom of tableview
    private func scrollToBottom()  {
        let point = CGPoint(x: 0, y: self.table.tableView.contentSize.height + self.table.tableView.contentInset.bottom - self.table.tableView.frame.height)
            if point.y >= 0{
                self.table.tableView.setContentOffset(point, animated: true)
            }
    }
    
    /// listener notification keyboard hide & show functions
    private func listenerTextFieldNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: MyMessageCellDelegate this delegate worked when pressed toolbars btns in MyMessageCell
extension AddMarkViewController: MyMessageCellDelegate {
    func didDoneTapped() {
        self.dismissKeyboard()
    }
}

//MARK: - AddMarkCellDelegate this delegate worked when pressed gender btn in AddMarkCell
extension AddMarkViewController: AddMarkCellDelegate {
    func didGenderBtnTapped() {
    
        let alert = UIAlertController(title: "Choose your gender", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Male", style: .default, handler: { (_) in
                self.userGender = .male
                self.table.tableView.reloadData()
            }))

            alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { (_) in
                self.userGender = .female
                self.table.tableView.reloadData()
            }))

            alert.addAction(UIAlertAction(title: "None", style: .destructive, handler: { (_) in
                self.userGender = .none
                self.table.tableView.reloadData()
            }))

            self.present(alert, animated: true, completion: {
                
            })
    }
    
}
