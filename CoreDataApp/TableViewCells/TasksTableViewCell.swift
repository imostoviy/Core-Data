//
//  TableViewCell.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/30/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let reuseIdentifier = "TaskCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
