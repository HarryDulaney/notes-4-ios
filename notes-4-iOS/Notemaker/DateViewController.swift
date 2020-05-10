//
//  DateViewController.swift
//  My Contact Application2
//
//  Created by Harry Dulaney on 11/4/19.
//

import UIKit

protocol DateControllerDelegate: class {
    func dateChanged(date: Date)
    
}

class DateViewController: UIViewController {
    
    weak var delegate: DateControllerDelegate?
    
    @IBOutlet weak var dtpDate: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        // Do any additional setup after loading the view.
        let saveButton: UIBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                            target: self,
                            action: #selector(saveDate))
            
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Pick Date Now"
        
    }
    
    @objc func saveDate() {
        self.delegate?.dateChanged(date: dtpDate.date)
        let navController = self.navigationController
                  navController?.popViewController(animated: true)

        
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
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
