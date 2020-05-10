//
//  Settings2ViewController.swift
//  Notemaker
//
//  Created by Ben Abadie on 12/2/19.
//  Copyright © 2019 Ben-Logan-Harry. All rights reserved.
//

import UIKit

class Settings2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var pckSortField: UIPickerView!
    @IBOutlet weak var swAscending: UISwitch!
    @IBOutlet var settingsView: UIView!
    
    let sortOrderItems: Array<String> = ["title","subject","priority"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pckSortField.dataSource = self
        pckSortField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(swAscending.isOn, forKey: Constants.kSortDirectionAscending)
        settings.synchronize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.motionManager.stopAccelerometerUpdates()
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
        swAscending.setOn(settings.bool(forKey: Constants.kSortDirectionAscending),animated: true)
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        
        for field in sortOrderItems {
            if field == sortField {
            pckSortField.selectRow(i, inComponent: 0, animated: false)
        }
            i += 1
    }
         pckSortField.reloadComponent(0)
    }
    
    

    

}
