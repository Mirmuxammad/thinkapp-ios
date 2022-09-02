//
//  WelcomeController.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import UIKit

class WelcomeController: UIViewController, Routable {
    
    var router: MainRouter?
    
    private let baseView: WelcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.getStartAddTarget(target: self, action: #selector(getStart))
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        baseView.frame = view.bounds
        view.addSubview(baseView)
    }
    
    @objc private func getStart() {
        router?.pushMainMap()
    }
}
