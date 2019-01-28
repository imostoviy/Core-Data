//
//  ParentTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/28/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class ParentTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFunction))
    }
    
    @objc func addFunction() {}

}

