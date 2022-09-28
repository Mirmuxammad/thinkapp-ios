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
    private weak var maxDistanceButton: UIButton?
    private weak var ageRangeButton: UIButton?
    
    // MARK: - Public Properties
    var router: MainRouter?
    
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
            return genderPreferenceCell
        
        case .MaxDistance:
            let maxDistanceCell = tableView.dequeueReusableCell(withIdentifier: MaxDistanceCell.identifier,
                                                                for: indexPath) as! MaxDistanceCell
            maxDistanceCell.maxDistanceSlider.delegate = self
            maxDistanceButton = maxDistanceCell.maxDistanceButton
            return maxDistanceCell
        
        case .AgeRange:
            let ageRangeCell = tableView.dequeueReusableCell(withIdentifier: AgeRangeCell.identifier,
                                                             for: indexPath) as! AgeRangeCell
            ageRangeCell.ageRangeSlider.delegate = self
            ageRangeButton = ageRangeCell.ageRangeButton
            ageRangeCell.ageRangeSlider.leftKnobImage = UIImage(named: "knob")
            return ageRangeCell
        
        case .DoneButton:
            let doneButtonCell = tableView.dequeueReusableCell(withIdentifier: DoneButtonCell.identifier,
                                                               for: indexPath) as! DoneButtonCell
            doneButtonCell.doneAddTarget(target: self, action: #selector(back))
            return doneButtonCell
        }
    }
    
    @objc private func back() {
        router?.back()
//        router?.pushChat()
    }
}

// MARK: - UITableViewDelegate
extension FiltersViewController: UITableViewDelegate {
    
}

// MARK: - RangeUISliderDelegate
extension FiltersViewController: RangeUISliderDelegate {
    func rangeChangeFinished(event: RangeUISliderChangeFinishedEvent) {
        
    }
    
    
    func rangeChangeFinished(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
    
    }
    
    func rangeIsChanging(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
        switch slider.accessibilityIdentifier {
        case "maxDistanceSlider":
            maxDistanceButton?.setTitle("\(Int(minValueSelected))-\(Int(maxValueSelected)) Km", for: .normal)
        case "ageRangeSlider":
            ageRangeButton?.setTitle("\(Int(minValueSelected))-\(Int(maxValueSelected)) Age", for: .normal)
        default:
            break
        }
    }
}
