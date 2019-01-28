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
        fullNameLabel.text = fullName
        experienceLabel.text = experience
        otherTaskLabel.text = otherTask
        bossLabel.text = boss
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: outlets
    
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var experienceLabel: UILabel!
    @IBOutlet private weak var otherTaskLabel: UILabel!
    @IBOutlet weak var bossLabel: UILabel!
    @IBOutlet var mainTaskLabel: UILabel!
    
    //MARK: public properties
    
    var fullName: String?
    var experience: String? {
        set {
            self.experience = "XP(months): " + (newValue ?? "")
        }
        get {
            return self.experience
        }
    }
    var otherTask: String? {
        set {
            self.otherTask = "OT: " + (newValue ?? "")
        }
        get {
            return self.otherTask
        }
    }
    var boss: String? {
        set {
            self.boss = "Boss: " + (newValue ?? "")
        }
        get {
            return self.boss
        }
    }
    var mainTask: String? {
        set {
            self.mainTask = "MT: " + (newValue ?? "")
        }
        get {
            return self.mainTask
        }
    }
    static let reuseIdentifier = "developersCell"
}
