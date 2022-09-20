//
//  ChatController.swift
//  thinkapp-ios
//
//  Created by Mavlon on 16/09/22.
//

import UIKit
import SnapKit

class ChatController: UIViewController, Routable {
    
    var router: MainRouter?
    private weak var tableView: UITableView?
    private var baseView: ChatView = ChatView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        conformProtocols()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        baseView.frame = view.bounds
        view.addSubview(baseView)
    }
    
    // MARK: - Private Actions
    @objc private func back() {
        router?.back()
    }
    
    // MARK: - Set Actions
    func addTargets() {
        tableView = baseView.tableView
        baseView.backAddTarget(target: self, action: #selector(back))
    }
    
    func conformProtocols() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

//MARK: - TableView Methods
extension ChatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "234242"
        return cell
    }
    
}
