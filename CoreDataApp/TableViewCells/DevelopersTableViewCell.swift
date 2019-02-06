//
//  DevelopersTableViewCell.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/28/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class DevelopersTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: outlets
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var otherTaskLabel: UILabel!
    @IBOutlet weak var bossLabel: UILabel!
    @IBOutlet var mainTaskLabel: UILabel!
    
    static let identifier = "developersCell"
}
