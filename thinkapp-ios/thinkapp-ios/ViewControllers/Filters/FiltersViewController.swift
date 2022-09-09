//
//  FiltersViewController.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit

class FiltersViewController: UIViewController, Routable {
    
    private let table: FiltersTableView = FiltersTableView()
    
    var router: MainRouter?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        conformProtocols()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        table.frame = view.bounds
        view.addSubview(table)
    }
    
    // MARK: - Private Methods
    private func conformProtocols() {
        table.tableView.delegate = self
        table.tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let genderPreferenceCell = tableView.dequeueReusableCell(withIdentifier: GenderPreferenceCell.identifier,
                                                                     for: indexPath) as! GenderPreferenceCell
            return genderPreferenceCell
        case 1:
            let maxDistanceCell = tableView.dequeueReusableCell(withIdentifier: MaxDistanceCell.identifier,
                                                                for: indexPath) as! MaxDistanceCell
            return maxDistanceCell
        case 2:
            let ageRangeCell = tableView.dequeueReusableCell(withIdentifier: AgeRangeCell.identifier,
                                                             for: indexPath) as! AgeRangeCell
            return ageRangeCell
        case 3:
            let doneButtonCell = tableView.dequeueReusableCell(withIdentifier: DoneButtonCell.identifier,
                                                               for: indexPath) as! DoneButtonCell
            return doneButtonCell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension FiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 81
        default:
            return 119
        }
    }
}
