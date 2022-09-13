//
//  AddMarkTableView.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 11.09.2022.
//

import UIKit
import SnapKit

class AddMarkTableView: UIView {
    
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
    
    private func addViews() {
        addSubview(tableView)
    }
        
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
