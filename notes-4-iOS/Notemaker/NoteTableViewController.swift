//
//  NoteListViewController.swift
//  Notetaker-1.0
//
//  Created by Harry Dulaney on 11/26/19.
//  Copyright © 2019 Ben-Logan-Harry. All rights reserved.
//

import CoreData
import UIKit

class NoteTableViewController: UITableViewController {
    
       var notes:[NSManagedObject] = []
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        loadDataFromDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
             loadDataFromDatabase()
             tableView.reloadData()
         }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    func loadDataFromDatabase() {
        //Read settings to enable sorting
        let settings = UserDefaults.standard
        let sortField = settings.string(forKey: Constants.kSortField)
        let sortAscending = settings.bool(forKey: Constants.kSortDirectionAscending)
        //Set up Core Data Context
        let context = appDelegate.persistentContainer.viewContext
        //Set up Request
        let request = NSFetchRequest<NSManagedObject>(entityName: "Note")
        //Specify sorting
        let sortDescriptor = NSSortDescriptor(key: sortField, ascending: sortAscending)
        let sortDescriptorArray = [sortDescriptor]
        //to sort by multiple fields, add more sort descriptors to the array
        request.sortDescriptors = sortDescriptorArray
        
        //Execute request
        do {
            notes = try context.fetch(request)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)

        // Configure the cell...
        let note = notes[indexPath.row] as? Note
        cell.textLabel?.text = note?.title
        cell.detailTextLabel?.text = note?.subject
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        return cell
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditNote" {
        let noteController = segue.destination as? NoteViewController
        let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
        let selectedNote = notes[selectedRow!] as? Note
        noteController?.currentNote = selectedNote!
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row] as? Note
        let name = selectedNote!.title!
        
        let actionHandler = { (action:UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "EditNote", sender: tableView.cellForRow(at: indexPath))
        }
        let alertController = UIAlertController(title: "Note selected",
                                                message: "Selected row: \(indexPath.row) (\(name))",
                                                 preferredStyle: .alert) //Lines 114-116 set up the UIAlertController with a title and message. The preferred style can either be .alert (which we are using) or .actionsheet. The action sheet is used when more than two or three options are needed, as it stacks the buttons on top of each other.
        
        let actionCancel = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil) //Lines 117–120 set up two UIAlertAction objects, one for each of the buttons. The first one is for Cancel and is very simple. Notice that the style is set as .cancel. Only one button an alert controller can use the cancel style. The second one uses the default style, but more interestingly, it has the reference to the actionHandler, so when the user taps the Show Details button, the code in actionHandler is executed.
        let actionDetails = UIAlertAction(title: "Show Details",
                                          style: .default,
                                          handler: actionHandler)
        alertController.addAction(actionCancel)//Lines 124 and 125 add the two buttons to the Alert Controller, and line 20 displays the controller. When you run the app, you should now be able to tap a cell in the table and see the alert. Taping Show Details should bring up the Contact editing screen.
        alertController.addAction(actionDetails)
        present(alertController, animated: true, completion: nil)

    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              // Delete the row from the data source
              let note = notes[indexPath.row] as? Note
              let context = appDelegate.persistentContainer.viewContext
              context.delete(note!)
              do {
                  try context.save()
              }
              catch {
                  fatalError("Error saving context: \(error)")
              }
              loadDataFromDatabase()
              tableView.deleteRows(at: [indexPath], with: .fade)
          } else if editingStyle == .insert {
              // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
          }
      }
    

}


/**
 //
 //  MemoTableViewController.swift
 //  MyMemo
 //
 //  Created by Cistudent on 11/26/19.
 //  Copyright © 2019 Cistudent. All rights reserved.
 //

 import UIKit
 import CoreData

 class MemoTableViewController: UITableViewController {
     
     var memos:[NSManagedObject] = []
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         self.navigationItem.leftBarButtonItem = self.editButtonItem
         loadDataFromDatabase()
     }
     
     override func viewWillAppear(_ animated: Bool) {
         loadDataFromDatabase()
         tableView.reloadData()
     }
     
     func loadDataFromDatabase() {
         let settings = UserDefaults.standard
         var sortField = settings.string(forKey: Constants.kSortField)
         
         //sorting function!!!!!!!!!!!!!!!!!
         
         var priority = true
         if sortField == "high" {
             sortField = "prio"
             priority = true
         }
         if sortField == "low" {
             sortField = "prio"
             priority = false
         }
     
         let context = appDelegate.persistentContainer.viewContext
         let request = NSFetchRequest<NSManagedObject>(entityName: "Memo")
         let sortDescriptor = NSSortDescriptor(key: sortField, ascending: priority)
         let sortDescriptorArray = [sortDescriptor]
         request.sortDescriptors = sortDescriptorArray
         do {
             memos = try context.fetch(request)
         } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
         }
     }

     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }

     // MARK: - Table view data source

     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return memos.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
         let memo = memos[indexPath.row] as? Memo
         cell.textLabel?.text = memo?.memoTitle
       
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         if memo?.memo_date != nil {
             cell.detailTextLabel?.text = formatter.string(from: memo!.memo_date as! Date)
         }
         else {
             cell.detailTextLabel?.text = "Date: "
         }
  
         cell.accessoryType = .detailDisclosureButton
         return cell
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "EditMemo" {
             let memoController = segue.destination as? MemoViewController
             let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
             let selectedMemo = memos[selectedRow!] as? Memo
             memoController?.currentMemo = selectedMemo!
         }
     }
     

     /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

     
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
             
             let memo = memos[indexPath.row] as? Memo
             let context = appDelegate.persistentContainer.viewContext
             context.delete(memo!)
             do {
                 try context.save()
             }
             catch {
                 fatalError("Error saving context: \(error)")
             }
             
             loadDataFromDatabase()
             tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
     

     /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

     /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */

     /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
     }
     */

 }

 */

