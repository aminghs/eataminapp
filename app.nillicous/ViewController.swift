//
//  ViewController.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/12/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import UIKit
import CoreData




class ViewController: BaseAdapter {

    @IBAction func unwindToThisViewController(_ segue: UIStoryboardSegue) {
        print("Returned from detail screen")
        
    }
   
    @IBOutlet weak var internetStatusView: UIView!
    
    @IBOutlet weak var splashImageView: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
        
        //Status bar style and visibility
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = component().setBgColor(122,green: 122, blue:122)
        }
        
    }
    
    @IBOutlet weak var showTabButtom: UIButton!
    @IBAction func showTabView(_ sender: AnyObject) {
        
        timeToMoveOn()

        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let netView = internetStatusView
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ViewController.viewTapped(_:)))
        netView?.isUserInteractionEnabled = true
        netView?.addGestureRecognizer(tapGestureRecognizer)
        
        
       // print("******************************************")
       // print(UserDefaults.standard.object(forKey: "notification"))
       // print("******************************************")

        
        var firstTimeLoad = false
            firstTimeLoad =  UserDefaults.standard.bool(forKey: "firstTimeLoad")
        if  !firstTimeLoad {
            self.emptyTheFoodsTB()
            UserDefaults.standard.set(true, forKey: "firstTimeLoad")
        }
        
        

        
        
        
    }
    
    func viewTapped(_ img: AnyObject)
    {
        
        if Reachability.isConnectedToNetwork() {
            getNews()
        }else{
           self.internetStatusView.alpha = 1
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
            //NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "notification")
            //dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
       
       do {
        let nStr = UserDefaults.standard.object(forKey: "notification") as? [String: AnyObject]
        if nStr != nil  {
           
                
            if let aps = nStr!["aps"] as? NSDictionary {
                if let alert = aps["alert"] as? NSString {
                    print(alert)
                }
                if let sdata = aps["data"] as? NSString {
                    print(sdata)
                    
                    let jsonData: Data = sdata.data(using: String.Encoding.utf8.rawValue)!
                   
                        let  json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                        if let type = json!["type"] as? String {
                            print(type)
                            switch type {
                            case "news":
                                if let notificationId = json!["notificationId"] as? String {
                                    self.setDelivery(notificationId)
                                }
                                if let newsId = json!["newsId"] as? String {
                                    UserDefaults.standard.set(newsId, forKey: "newsId")
                                 //   timeToMoveOn()
                                    
                                                                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsChild") as UIViewController
                                                                                self.present(viewController, animated: false, completion: nil)
                                    
                            
                                }
                                
                                                                            UserDefaults.standard.set(nil, forKey: "notification")
                            case "restaurant":
                                if let notificationId = json!["notificationId"] as? String {
                                    self.setDelivery(notificationId)
                                }
                                    if let restaurantId = json!["restaurantId"] as? String {
                                       UserDefaults.standard.set(restaurantId, forKey: "restaurantId")
                                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurantsChild") as UIViewController
                                    self.present(viewController, animated: false, completion: nil)
                                    
                                   }
                                  
                                UserDefaults.standard.set(nil, forKey: "notification")
                            default:
                                if let notificationId = json!["notificationId"] as? String {
                                    self.setDelivery(notificationId)
                                }
                                   UserDefaults.standard.set(nil, forKey: "notification")
                                //print("not news!")
                                timeToMoveOn()
                                
                            }
                        }
                   
                    
                }
            }
            
            
           
            
        }else{
        
            getNews()
            
            
        }
       }catch {
        
        UserDefaults.standard.set(nil, forKey: "notification")
        getNews()
        
        }
        
        
        
    }
    
    func timeToMoveOn() {
        self.performSegue(withIdentifier: "showTabView", sender: "")
        
    }
    func getNews(){
        
        self.showTabButtom.setTitle("کمی صبر کنید...", for: UIControlState())
        self.internetStatusView.alpha = 0
        
        let session = URLSession.shared
        let url = URL(string: mainUrl+newsUrl)!
        
        let request = NSMutableURLRequest(url: url)
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            //
            //        dispatch_async(dispatch_get_main_queue(), {

            
                
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                                        
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response get News")
                    
                     self.showTabButtom.setTitle("اشکال در ارتباط با سرور", for: UIControlState())
                    self.internetStatusView.alpha = 1

                    return
                }
                
        
                
                var i = 0;
                do {
                    
                    if let newsString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                        
                        self.parseJsonArray(data!)
                        
                    }
                    
                }catch{
                    
                    
                }
                
                
                DispatchQueue.main.async {
                    // print("")
                    //self.showTabButtom.setTitle("برای ورود کلیک کنید", forState: UIControlState.Normal)
                    self.showTabButtom.setTitle("", for: UIControlState())
                    self.timeToMoveOn()
                    
                  //  self.showTabButtom.setTitle("COMING SOON!", forState: UIControlState.Normal)

                    
                }
                //hide indicator after data is loaded
                })
            task.resume()
            
        })
        
        
        
    }
    func emptyTheFoodsTB(){
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        do{
           // let request = NSFetchRequest(entityName: "News")
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")

            var myList = try context.fetch(request)
            
            var bas: NSManagedObject!
            for bas: Any in myList
            {
                context.delete(bas as! NSManagedObject)
            }
            myList.removeAll(keepingCapacity: false)
            
            try context.save()
            
        }catch{
            
        }
        
        
    }

    
    func setDelivery(_ nid: String){
        
        
        let session = URLSession.shared
        let url = URL(string: mainUrl+deliveryUrl)!
        let request = NSMutableURLRequest(url: url)
        
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        let postString = "nid=\(nid)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        DispatchQueue.main.async(execute: {
            
            
                let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in

                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response Set Delivery!")
                    
                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                  //  print(ipString)
                    
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    
                    
                }
                //hide indicator after data is loaded
                })
            task.resume()
            
        })
        
        
        
    }
    
    

    
    
}

