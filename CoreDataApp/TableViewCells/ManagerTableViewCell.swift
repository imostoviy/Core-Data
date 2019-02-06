//
//  ManagerTableViewCell.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/28/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class ManagerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: private outlets
    
    @IBOutlet weak var fullNAmeLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var tasksLabel: UILabel!
    
    static let reuseIdentifier = "ManagerTableViewCell"
}
