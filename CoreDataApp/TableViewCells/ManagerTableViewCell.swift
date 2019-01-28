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
    
    @IBOutlet private weak var fullNAmeLabel: UILabel!
    @IBOutlet private weak var experienceLabel: UILabel!
    @IBOutlet private weak var customerLabel: UILabel!
    
    //MARK: publec properties
    var fullName: String? {
        set {
            self.fullName = "Name: " + (newValue ?? "")
        }
        get {
            return self.fullName
        }
    }
    var experience: String? {
        set {
            self.experience = "XP(months)" + (newValue ?? "")
        }
        get {
            return self.experience
        }
    }
    var customer: String? {
        set {
            self.customer = "Customer " + (newValue ?? "")
        }
        get {
            return self.customer
        }
    }
}
