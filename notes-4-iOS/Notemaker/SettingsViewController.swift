//
//  ViewController.swift
//  Notetaker-1.0
//
//  Created by Harry Dulaney on 11/26/19.
//  Copyright © 2019 Ben-Logan-Harry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var pckSortField: UIPickerView!
    @IBOutlet weak var swAscendingNew: UISwitch!
    @IBOutlet var settingsView: UIView!
    
    
    let sortOrderItems: Array<String> = ["title","subject","dateCreated"]


override func viewDidLoad() {
    super.viewDidLoad()
    //pckSortField.dataSource = self;
    //pckSortField.delegate = self;
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    //Dispose of any resources that can be recreated
}

    
//MARK: UIPickerViewDelegate Methods

    @IBAction func sortDirectionChangedNew(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(swAscendingNew.isOn, forKey: Constants.kSortDirectionAscending)
        settings.synchronize()

    }
    //Returns the # of 'columns' to display
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

//Returns the # of rows in the picker
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    return sortOrderItems.count
}
//Sets the value shown for each row in picker
func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
    return sortOrderItems[row]
}
//Trigger for when user interacts with the userview
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let sortField = sortOrderItems[row]
    let settings = UserDefaults.standard
    settings.set(sortField, forKey: Constants.kSortField)
    settings.synchronize()

}
override func viewWillAppear(_ animated: Bool) {
    //Set the UI using the values store in User_Defaults
    let settings = UserDefaults.standard
    swAscendingNew.setOn(settings.bool(forKey: Constants.kSortDirectionAscending),animated: true)
    let sortField = settings.string(forKey: Constants.kSortField)
    var i = 0
    
    for field in sortOrderItems {
        if field == sortField {
        //pckSortField.selectRow(i, inComponent: 0, animated: false)
    }
        i += 1
}
     //pckSortField.reloadComponent(0)
}

override func viewDidDisappear(_ animated: Bool) {
    //let appDelegate = UIApplication.shared.delegate as? AppDelegate
    //appDelegate?.motionManager.stopAccelerometerUpdates()
    
}
   
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
}


