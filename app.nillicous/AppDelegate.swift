//
//  AppDelegate.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/12/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import UIKit
import CoreData
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        FIRApp.configure()

        let notificationTypes : UIUserNotificationType = [.alert, .badge, .sound]
        let notificationSettings : UIUserNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        // Override point for customization after application launch.
        
        
        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            UserDefaults.standard.set(notification, forKey: "notification")
        }
        
        
        return true
    }
    
    
    
    
    
    
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings)
    {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        

        var trimmedString = deviceToken.hexString()
        

//        var trimmedString = ""
//        trimmedString = String(describing: deviceToken).replacingOccurrences(of: "<", with: "")
//        trimmedString = trimmedString.replacingOccurrences(of: ">", with: "")
//        trimmedString = trimmedString.replacingOccurrences(of: " ", with: "")
        
        
        //print("*************")
        //print(trimmedString)
        
        
        if (trimmedString != "32bytes" && trimmedString.characters.count > 8) {
            
            if UserDefaults.standard.object(forKey: "boolDeviceToken") == nil {
                
                //print("*************")
                //print(trimmedString)
                
               // trimmedString = "debug_" + trimmedString
                UserDefaults.standard.set(trimmedString, forKey: "deviceToken")
                
                
                var UniqueId = UIDevice.current.identifierForVendor!.uuidString
                UniqueId = UniqueId.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                let index = UniqueId.characters.index(UniqueId.startIndex, offsetBy: 20)
                UniqueId = UniqueId.substring(to: index)
                UserDefaults.standard.set(UniqueId, forKey: "uniqueId")
                
                
                
            }
            
        }
     //   if UserDefaults.standard.object(forKey: "boolTokenSetIntheServer") == nil {
            if UserDefaults.standard.string(forKey: "deviceToken") != nil {
                self.setToken(UserDefaults.standard.string(forKey: "deviceToken")!, uid: UserDefaults.standard.string(forKey: "uniqueId")!)
            }
            
     //   }
        
        //A916E9AF-17D7-43C6-A34F-24AD34F44331
        


    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

        
        print("did recieve notification!")
        print(userInfo)
    
        UserDefaults.standard.set(userInfo, forKey: "notification")
        if  application.applicationState != UIApplicationState.active

        {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "SomeNotification"), object:nil, userInfo: userInfo)
        }
        

//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let rootVC = storyboard.instantiateViewControllerWithIdentifier("newsId") as! UITabBarController
//       // if PFUser.currentUser() != nil {
//            //rootVC.selectedIndex = 2 // Index of the tab bar item you want to present, as shown in question it seems is item 2
//            self.window!.rootViewController = rootVC
//      //  }
//        let nStr = userInfo
//        do {
//            
//            if let aps = nStr["aps"] as? NSDictionary {
//                if let alert = aps["alert"] as? NSString {
//                    print(alert)
//                }
//                if let sdata = aps["data"] as? NSString {
//                    print(sdata)
//                    
//                    let jsonData: NSData = sdata.dataUsingEncoding(NSUTF8StringEncoding)!
//                    
//                    let  json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions()) as? NSDictionary
//                    if let type = json!["type"] as? String {
//                        print(type)
//                        switch type {
//                        case "news":
//                            if let notificationId = json!["notificationId"] as? String {
//                                self.setDelivery(notificationId)
//                            }
//                            if let newsId = json!["newsId"] as? String {
//                                NSUserDefaults.standardUserDefaults().setObject(newsId, forKey: "newsId")
//                                //   timeToMoveOn()
//                                
//                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewsChild") as UIViewController
//                                presentViewController(viewController, animated: false, completion: nil)
//                                
//                                
//                            }
//                            
//                            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "notification")
//                        case "restaurant":
//                            if let notificationId = json!["notificationId"] as? String {
//                                self.setDelivery(notificationId)
//                            }
//                            if let restaurantId = json!["restaurantId"] as? String {
//                                NSUserDefaults.standardUserDefaults().setObject(restaurantId, forKey: "restaurantId")
//                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RestaurantsChild") as UIViewController
//                                self.presentViewController(viewController, animated: false, completion: nil)
//                                
//                            }
//                            
//                            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "notification")
//                        default:
//                            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "notification")
//                            //print("not news!")
//                            timeToMoveOn()
//                            
//                        }
//                    }
//                    
//                    
//                }
//            }
//            
//            
//        }catch {
//            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "notification")
//        }
//        //Parsing userinfo:
//        var temp : NSDictionary = userInfo
//        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
//        {
//            var alertMsg = info["alert"] as! String
//            var alert: UIAlertView!
//            alert = UIAlertView(title: "", message: alertMsg, delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//        }
        
        
    }
    
    /**/
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.app_nillicous" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "app_nillicous", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
      
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            
//            do {
//                let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
//                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
//            } catch {
//                print("this is error of migration\(error)")
//            }
            
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    func setToken(_ token: String,uid: String){
        
        
        let session = URLSession.shared
        let url = URL(string: mainUrl+setTokenUrl)!
        let request = NSMutableURLRequest(url: url)
        
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        let postString = "token=\(token)&uid=\(uid)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                
                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response Set Token")
                    
                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                    // print(ipString)
                    
                    /**/
                    do{
                        
                        let arr = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        if let groups = arr as? AnyObject {
                            
                            if let result = groups["result"] as? String {
                                
                                if result == "success" {
                                    
                                    UserDefaults.standard.set(true, forKey: "boolTokenSetIntheServer")
                                    UserDefaults.standard.set(true, forKey: "boolUniqueId")
                                    UserDefaults.standard.set(true, forKey: "boolDeviceToken")
                                    
                                }
                            }
                            
                        }
                        
                    }catch{
                        print("this is error \(error)")
                    }
                    /**/
                    
                    
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    
                    
                }
                //hide indicator after data is loaded
            })
            task.resume()
            
        })
        
        
        
    }



}

extension Data {
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
}

