//
//  FiltersViewController.swift
//  thinkapp-ios
//
//  Created by Ilyas Tyumenev on 06.09.2022.
//

import UIKit

class FiltersViewController: UITableViewController, Routable {    

    var router: MainRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func pressDoneButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
