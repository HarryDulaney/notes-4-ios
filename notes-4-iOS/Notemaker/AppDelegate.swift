//
//  AppDelegate.swift
//  Notemaker
//
//  Created by Harry Dulaney on 11/28/19.
//  Copyright © 2019 Ben-Logan-Harry. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var motionManager = CMMotionManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
               // Override point for customization after application launch.
    
            let settings = UserDefaults.standard
            
            if(settings.string(forKey: Constants.kSortField) == nil) {
                settings.set("title", forKey: Constants.kSortField)
            }
            if(settings.string(forKey: Constants.kSortDirectionAscending) == nil) {
                settings.set(true, forKey: Constants.kSortDirectionAscending)
            }
           
            settings.synchronize()
            NSLog("Sort field: %@", settings.string(forKey: Constants.kSortField)!)
                NSLog("Sort direction: \(settings.bool(forKey: Constants.kSortDirectionAscending))")
                
               return true
        
        //The bulk of the method is two if statements that check whether a value is already stored with two specific keys in the settings object. The first one (line 22) checks if the sortField has been set. If not, it stores City as the value in sortField in line 23. This approach ensures there is a value in the field, but also avoids overwriting any existing value.
        

        
        //The second if statement in lines 27-29 repeats the same check for the sort direction. If no value is stored, it defaults to true.
      
        
        //Line 32 ensures that any changes are saved back to the settings file, and lines 33 and 34 write the values of the two settings fields to NSLog. This shows how to retrieve a Boolean value using the bool(:ForKey:) method and retrieve a string by using string(:ForKey:).
       
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Notemaker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

