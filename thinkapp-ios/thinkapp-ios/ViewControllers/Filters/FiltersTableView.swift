//
//  FiltersTableView.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 09.09.2022.
//

import UIKit
import SnapKit

class FiltersTableView: UIView {
    
    // MARK: - Private Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
        registerCells()
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset.left = 0
    }
    
    private func registerCells() {
        tableView.register(GenderPreferenceCell.self, forCellReuseIdentifier: GenderPreferenceCell.identifier)
        tableView.register(MaxDistanceCell.self, forCellReuseIdentifier: MaxDistanceCell.identifier)
        tableView.register(AgeRangeCell.self, forCellReuseIdentifier: AgeRangeCell.identifier)
        tableView.register(DoneButtonCell.self, forCellReuseIdentifier: DoneButtonCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func addViews() {
        addSubview(tableView)
    }
        
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
