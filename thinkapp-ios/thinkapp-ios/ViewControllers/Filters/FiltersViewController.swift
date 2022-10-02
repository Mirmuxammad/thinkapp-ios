//
//  FiltersViewController.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit
import RangeUISlider

class FiltersViewController: UIViewController, Routable {
    
    // MARK: - Private Properties
    private let table: FiltersTableView = FiltersTableView()
    private var dataSourceArray = [FiltersCellType]()
    private weak var maxDistanceText: UILabel?
    private weak var ageRangeText: UILabel?
    
    // MARK: - Public Properties
    var router: MainRouter?
    var gender: Gender = .female
    private var maxDistance: Double?
    private var ageFrom: Double?
    private var ageTo: Double?
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        dataSourceArray = [.BackButton, .GenderPreference, .MaxDistance, .AgeRange, .DoneButton]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        conformProtocols()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        table.frame = view.bounds
        view.addSubview(table)
    }
    
    // MARK: - Private Methods
    private func registerCells() {
        table.tableView.register(BackButtonCell.self, forCellReuseIdentifier: BackButtonCell.identifier)
        table.tableView.register(GenderPreferenceCell.self, forCellReuseIdentifier: GenderPreferenceCell.identifier)
        table.tableView.register(MaxDistanceCell.self, forCellReuseIdentifier: MaxDistanceCell.identifier)
        table.tableView.register(AgeRangeCell.self, forCellReuseIdentifier: AgeRangeCell.identifier)
        table.tableView.register(DoneButtonCell.self, forCellReuseIdentifier: DoneButtonCell.identifier)
    }
    
    private func conformProtocols() {
        table.tableView.delegate = self
        table.tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = dataSourceArray[indexPath.row]
        switch typeCell {
        case .BackButton:
            let backButtonCell = tableView.dequeueReusableCell(withIdentifier: BackButtonCell.identifier,
                                                               for: indexPath) as! BackButtonCell
            backButtonCell.backAddTarget(target: self, action: #selector(back))
            return backButtonCell
        case .GenderPreference:
            let genderPreferenceCell = tableView.dequeueReusableCell(withIdentifier: GenderPreferenceCell.identifier,
                                                                     for: indexPath) as! GenderPreferenceCell
            genderPreferenceCell.genderBtnDelegate = self
            genderPreferenceCell.genderPreferenceButton.setTitle(gender.title, for: .normal)
            return genderPreferenceCell
            
        case .MaxDistance:
            let maxDistanceCell = tableView.dequeueReusableCell(withIdentifier: MaxDistanceCell.identifier,
                                                                for: indexPath) as! MaxDistanceCell
            maxDistanceCell.maxDistanceSlider.delegate = self
            maxDistanceText = maxDistanceCell.rangeLabel
            return maxDistanceCell
            
        case .AgeRange:
            let ageRangeCell = tableView.dequeueReusableCell(withIdentifier: AgeRangeCell.identifier,
                                                             for: indexPath) as! AgeRangeCell
            ageRangeCell.ageRangeSlider.delegate = self
            ageRangeText = ageRangeCell.rangeLabel
            ageRangeCell.ageRangeSlider.leftKnobImage = UIImage(named: "knob")
            return ageRangeCell
            
        case .DoneButton:
            let doneButtonCell = tableView.dequeueReusableCell(withIdentifier: DoneButtonCell.identifier,
                                                               for: indexPath) as! DoneButtonCell
            doneButtonCell.doneAddTarget(target: self, action: #selector(searchPressed))
            return doneButtonCell
        }
    }
    
    @objc private func back() {
        router?.back()
        //        router?.pushChat()
    }
    
    @objc private func searchPressed() {
        router?.startSearch(gender: self.gender.key,
                            maxDistance: self.maxDistance,
                            ageFrom: self.ageFrom,
                            ageTo: self.ageTo)
    }
}

// MARK: - UITableViewDelegate
extension FiltersViewController: UITableViewDelegate {
    
}

// MARK: - RangeUISliderDelegate
extension FiltersViewController: RangeUISliderDelegate {
    func rangeChangeFinished(event: RangeUISliderChangeFinishedEvent) {
        switch event.slider.accessibilityIdentifier {
        case "maxDistanceSlider":
            maxDistanceText?.text = "\(Int(event.minValueSelected))-\(Int(event.maxValueSelected)) Km"
            self.maxDistance = Double(event.maxValueSelected)
        case "ageRangeSlider":
            ageRangeText?.text = "\(Int(event.minValueSelected))-\(Int(event.maxValueSelected)) Age"
            self.ageFrom = Double(event.minValueSelected)
            self.ageTo = Double(event.maxValueSelected)
        default:
            break
        }
    }
}

//MARK: - FiltersViewController this delegate worked when pressed gender btn in GenderPreferenceCell
extension FiltersViewController: GenderPreferenceCellDelegate {
    func didGenderBtnTapped() {
        
        let alert = UIAlertController(title: "Choose your gender", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Gender.male.title, style: .default, handler: { (_) in
            self.gender = .male
            self.table.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: Gender.female.title, style: .default, handler: { (_) in
            self.gender = .female
            self.table.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: Gender.none.title, style: .destructive, handler: { (_) in
            self.gender = .none
            self.table.tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
}
