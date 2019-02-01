//
//  DesignersTableViewCell.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/28/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class DesignersTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: private outlets
    
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var experienceLabel: UILabel!
    @IBOutlet private weak var mainTaskLabel: UILabel!
    @IBOutlet private weak var bossLabel: UILabel!
    
    //MARK: public properties
    
    var fullName: String? {
        set {
            self.fullName = "Full name: " + (newValue ?? "")
        }
        get {
            return fullName
        }
    }
    var experience: String? {
        set {
            self.experience = "XP(months): " + (newValue ?? "")
        }
        get {
            return self.experience
        }
    }
    var mainTask: String?
    var boss: String? {
        set {
            self.boss = "Boss: " + (newValue ?? "")
        }
        get {
            return self.boss
        }
    }
    static let reuseIdentifier = "designerCell"
}
