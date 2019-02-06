//
//  UIPickerForBoss.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/29/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class UIPickerForBoss: UIPickerView {
    
    //Variable for UIPicker data source
    
    var listOfObjects: [Manager]?
    var selectedManager: ((Manager?) -> (Void))?
    static var alert: UIAlertController?
    
    
    
    //MARK: Function fot creating toolbar for Picker view
    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButtom = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissEditing))
        toolBar.setItems([doneButtom], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    @objc func dismissEditing() {
        UIPickerForBoss.alert?.view.endEditing(true)
    }
    
}

//MARK: Extension UIPEckerViewDelegate, dataSource
extension UIPickerForBoss: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfObjects?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfObjects?[row].fullName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedManager?(listOfObjects?[row])
    }
    
}
