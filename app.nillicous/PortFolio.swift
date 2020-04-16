//
//  PortFolio.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 8/7/17.
//  Copyright © 2017 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AlamofireImage




class PortFolio : BaseAdapter, UITableViewDelegate {
    
    @IBOutlet weak var internetStatusView: UIView!
    @IBOutlet weak var portfolioTableView: UITableView!
    var refreshControl: UIRefreshControl!
   // @IBOutlet weak var internetStatusView: UIView!
   // @IBOutlet weak var newsTableView: UITableView!
    var portFolioArrayDic:[Dictionary <String, String>] = []
    //var newsArrayDicR:[Dictionary <String, String>] = []
    let cache = NSCache<AnyObject, AnyObject>()//NSCache()
    
    
    @IBAction func deleteDb(_ sender: AnyObject) {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PortFolio")//NSFetchRequest(entityName: "News")
            var myList = try context.fetch(request)
            
            var bas: NSManagedObject!
            
            for bas: Any in myList
            {
                context.delete(bas as! NSManagedObject)
            }
            
            myList.removeAll(keepingCapacity: false)
            
            //      tv.reloadData()
            try context.save()
            
            //  }
        }catch{
            
        }
        
    }
    // add this function. When the detail ViewController is unwound, it executes this
    // function
    
    @IBAction func unwindToThisPortFolioViewController(_ segue: UIStoryboardSegue) {
        //print("Returned from detail screen")
        UITabBar.appearance().alpha = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
        
        //Status bar style and visibility
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = component().setBgColor(37,green: 203, blue:107)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        component().setNavigationBarColorAndFont()
        
        //tab bar font and color!
        let colorNormal : UIColor = UIColor.black
        let colorSelected : UIColor = component().setBgColor(34,green: 192, blue:100)
        let titleFontAll : UIFont = UIFont(name: "IRANSans", size: 11.0)!
        
        let attributesNormal = [
            NSForegroundColorAttributeName : colorNormal,
            NSFontAttributeName : titleFontAll
        ]
        
        let attributesSelected = [
            NSForegroundColorAttributeName : colorSelected,
            NSFontAttributeName : titleFontAll
        ]
        
        // UITabBarItem.appearance().set
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        
        //  UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.blueColor(), size: CGSizeMake(UITabBar.frame.width/5, UITabBar.frame.height))
        
        
        
        
        // UITabBarItem.appearance()
        portFolioArrayDic = getPF()
        refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(PortFolio.refresh(_:)), for: UIControlEvents.valueChanged)
        portfolioTableView.addSubview(refreshControl) // not required when using UITableViewController
        
        
        let netView = internetStatusView
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(News.viewTapped(_:)))
        netView?.isUserInteractionEnabled = true
        netView?.addGestureRecognizer(tapGestureRecognizer)
        
        
        if UserDefaults.standard.object(forKey: "boolTokenSetIntheServer") == nil {
            if UserDefaults.standard.string(forKey: "deviceToken") != nil {
                self.setToken(UserDefaults.standard.string(forKey: "deviceToken")!, uid: UserDefaults.standard.string(forKey: "uniqueId")!)
            }
            
        }
        
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(rawValue: "SomeNotification"), object: nil)
        nc.addObserver(self, selector: #selector(SomeNotificationAct), name: NSNotification.Name(rawValue: "SomeNotification"), object: nil)
        
        
        
        if Reachability.isConnectedToNetwork() {
            self.refreshControl.beginRefreshing()
            getProtfolio()
        }else{
            self.refreshControl.endRefreshing()
            self.internetStatusView.alpha = 1
            
        }

    }
    
    func SomeNotificationAct(){
        
        
        
        DispatchQueue.main.async {
            
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
                                }
                            }
                            
                            
                        }
                    }
                    
                    
                    
                    
                }else{
                    
                    
                    
                }
            }catch {
                
                UserDefaults.standard.set(nil, forKey: "notification")
                
            }
            
        }
    }
    
    func viewTapped(_ img: AnyObject)
    {
        
        if Reachability.isConnectedToNetwork() {
            getProtfolio()
        }else{
            self.refreshControl.endRefreshing()
            self.internetStatusView.alpha = 1
            
        }
        
    }
    
    func refresh(_ sender:AnyObject) {
        
        if Reachability.isConnectedToNetwork() {
            getProtfolio()
        }else{
            self.refreshControl.endRefreshing()
            self.internetStatusView.alpha = 1
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        portfolioTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return portFolioArrayDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        var cellIdentifier =  "portFolioCustomRow"
        if component().isIphone(){
            cellIdentifier =  "portFolioCustomRow"
        }else{
            cellIdentifier =  "portFolioCustomRow"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! portFolioCustomRow
        var data  = portFolioArrayDic[(indexPath as NSIndexPath).row]
        cell.title?.text = data["title"]
        //cell.moreData?.text = "اطلاعات بیشتر"
        cell.body?.text = data["description"]
        cell.date?.text = data["create"]
        
        cell.date?.layer.cornerRadius = 5
        cell.date?.layer.masksToBounds = true
        
        
        do{
            if "1" != data["thumb"] as String! {
                let imageView = cell.pfImage
                let URL = Foundation.URL(string: data["thumb"]!)!
                let placeholderImage = UIImage(named: "defaults.jpg")!
                imageView?.af_setImage(withURL: URL, placeholderImage: placeholderImage)
            }else{
                cell.pfImage.image = UIImage(named: "defaults.jpg")!
            }
        }catch{
            print("image is null!")
            cell.pfImage.image = UIImage(named: "defaults.jpg")!
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
//    func insertDataIntoCacheImage(_ id: String, imageData: Data){
//        
//        //setUpCoreData
//        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
//        
//        // insert into db
//        let News = NSEntityDescription.insertNewObject(forEntityName: "CacheImage", into: contextNews)
//        News.setValue(id, forKey: "cImageId")
//        News.setValue(imageData, forKey: "cImageData")
//        
//        print("inserted item id in cacheed image \(id)")
//        
//        do{
//            try contextNews.save()
//        }catch{
//        }
//        
//    }
    
//    func getSpecificImage(_ id: String)-> Bool{
//        
//        var idIsFounded = false
//        
//        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context01: NSManagedObjectContext = appDel.managedObjectContext
//        // select from db
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CacheImage")//NSFetchRequest(entityName: "CacheImage")
//        request.predicate = NSPredicate(format: "cImageId == %@", id)
//        request.returnsObjectsAsFaults = false
//        
//        do{
//            let results = try context01.fetch(request)
//            
//            
//            do {
//                if (results.count > 0) {
//                    
//                    idIsFounded =  true
//                    return idIsFounded
//                    // print("Found")
//                    
//                } else {
//                    print("NotFound")
//                }
//                
//                
//                
//            } catch let error as NSError {
//                // failure
//                print("Fetch failed: \(error.localizedDescription)")
//            }
//            
//            
//            
//        }catch{
//            
//        }
//        
//        
//        return idIsFounded
//    }
    
    func getSpecifiImageFromDb(_ id: String)-> Data{
        
        var imageData = Data()
        
        
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context01: NSManagedObjectContext = appDel.managedObjectContext
        // select from db
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CacheImage");//NSFetchRequest(entityName: "CacheImage")
        request.predicate = NSPredicate(format: "cImageId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context01.fetch(request)
            
            
            
            if (results.count > 0) {
                
                for element in results {
                    
                    imageData = (element as AnyObject).value(forKey: "cImageData") as! Data
                    
                    
                }
                
                //idIsFounded =  true
                // return imageData
                //  print("Found")
                
            } else {
                print("NotFound")
            }
            
            
            
            
            
        }catch{
            
        }
        
        
        return imageData
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //NSLog("You selected cell number: \(indexPath.row)!")
        
        var data  = portFolioArrayDic[(indexPath as NSIndexPath).row]
        //  NSLog("You selected cell id: \(data["id"]!)")
        
        
       // self.performSegueWithIdentifier("PortFolioChild", sender: self)
        
        UserDefaults.standard.set(data["id"]!, forKey: "portfolioId")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PortFolioChild") as UIViewController
        self.present(viewController, animated: true, completion: nil)
        
        
    }
    
    func getProtfolio(){
        
        var isDataAvailable = false;
        self.internetStatusView.alpha = 0
        let session = URLSession.shared
        let url = URL(string: portFolioUrl)!
        let request = NSMutableURLRequest(url: url)
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    return
                }
                var i = 0;
                do {
                    if let newsString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                        self.parseJson(data!)
                        isDataAvailable = true
                    }
                }catch{
                }
                
                DispatchQueue.main.async {
                    if isDataAvailable {
                        self.refreshControl.endRefreshing()
                        self.portFolioArrayDic = []
                        self.portFolioArrayDic = self.getPF()
                        self.portfolioTableView.reloadData()
                    }else{
                        self.internetStatusView.alpha = 1
                        self.refreshControl.endRefreshing()
                    }
                }
                //hide indicator after data is loaded
            })
            task.resume()
            
        })
        
        
        
    }
    
    
    func parseJson(_ data: Data){
        
        
        do{
            
            let arr = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if let newsArray = arr as? [[String: AnyObject]]{
                
                
                
                var nId = ""
                var nTitle = ""
                var nDescription = ""
                var nRelation = ""
                var nThumb = ""
                var nSpecial = ""
                var nCreate = ""
                var nModify = ""
                var nTime = ""
                var nTimeStamp = 0
                var nRelationName = ""
                
                for news in newsArray {
                    
                    if let id = news["id"] as? String {
                        nId = id
                    }
                    if let title = news["title"] as? String{
                        nTitle = title
                    }
                    if let rDescription = news["description"] as? String{
                        nDescription = rDescription
                    }
                    
                    
                    
                    if let relation = news["relation"] as? [[AnyObject]] {
                        
                        // print(relation[0])
                        if relation.count>0 {
                            if let dd = relation[0] as? [AnyObject] {
                                
                                nRelation = String(dd[0] as! Int)
                                nRelationName = (dd[1] as! String)
                                
                            }else{
                                
                            }
                        }else{
                            nRelation = ""
                            nRelationName = ""
                            
                        }
                        
                    }
                    
                    
                    if let thumb = news["thumb"] as? String{
                        
                        if thumb.characters.count > 0 {
                            nThumb = mainUrlThumb+thumb
                        }else{
                            nThumb = "1"
                        }
                        
                    }
                    
                    
                    if let special = news["special"] as? String{
                        nSpecial = special
                    }
                    if let create = news["date"] as? String{
                        
                        nCreate = splitTheString(create)
                        
                    }
                    if let time = news["time"] as? String{
                        
                        nTime = time
                        
                    }
                    
                    if let timestamp = news["timestamp"] as? Int{
                        
                        nTimeStamp = timestamp
                        
                    }
                    
                    if let modify = news["modify"] as? String{
                        nModify = modify
                    }
                    
                    
                    if !self.getSpecificPortFolio(nId){
                        self.insertDataPF(nId,newsTitle: nTitle, newsDescription: nDescription, newsThumb: nThumb, newsSpecial: nSpecial, newsCreate: nCreate, newsModify:  nModify, newsRelation: nRelation, newsTime: nTime, newsTimeStamp: nTimeStamp, newsRelationName: nRelationName)
                    }else{
                        
                        //updateSpecialFieldInTB(nId, nSpecial: nSpecial, nRelation: nRelation, nRelationName: nRelationName)
                        self.updateSpecialFieldInPFTB(nId, nSpecial: nSpecial, nRelation: nRelation, nRelationName: nRelationName, nModify: nModify, nTitle: nTitle, nDescription: nDescription, nThumb: nThumb)
                    }
                    
                }
                
            }
            
            
        }catch{
            
            
        }
        
    }
    
    func getSpecificPortFolio(_ id: String)-> Bool{
        
        var idIsFounded = false
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context01: NSManagedObjectContext = appDel.managedObjectContext
        // select from db
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PortFolio")//NSFetchRequest(entityName: "News")
        request.predicate = NSPredicate(format: "nId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context01.fetch(request)
            
            
            do {
                if (results.count > 0) {
                    idIsFounded =  true
                    return idIsFounded
                    //   print("Found")
                } else {
                    //   print("NotFound")
                }
                
            } catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
            
        }catch{
        }
        return idIsFounded
    }

    func updateSpecialFieldInPFTB(_ nId: String, nSpecial: String, nRelation: String, nRelationName: String, nModify: String, nTitle: String, nDescription: String, nThumb: String ) {
        //setUpCoreData
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PortFolio")//NSFetchRequest(entityName: "News")
        fetchRequest.predicate = NSPredicate(format: "nId = %@", nId)
        do{
            if let fetchResults = try contextNews.fetch(fetchRequest) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    managedObject.setValue(nSpecial, forKey: "nSpecial")
                    managedObject.setValue(nRelation, forKey: "nRelation")
                    managedObject.setValue(nRelationName, forKey: "nRelationName")
                    managedObject.setValue(nThumb, forKey: "nThumb")
                    managedObject.setValue(nModify, forKey: "nModify")
                    managedObject.setValue(nTitle, forKey: "nTitle")
                    managedObject.setValue(nDescription, forKey: "nDescription")
                    try contextNews.save()
                }
            }
        }catch{
            
        }
    }

    func insertDataPF(_ newsId: String, newsTitle: String, newsDescription: String, newsThumb: String, newsSpecial: String, newsCreate: String, newsModify: String, newsRelation: String, newsTime: String, newsTimeStamp: Int, newsRelationName : String){
        
        //setUpCoreData
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
        
        // insert into db
        let News = NSEntityDescription.insertNewObject(forEntityName: "PortFolio", into: contextNews)
        News.setValue(newsId, forKey: "nId")
        News.setValue(newsTitle, forKey: "nTitle")
        News.setValue(newsDescription, forKey: "nDescription")
        News.setValue(newsThumb, forKey: "nThumb")
        News.setValue(newsSpecial, forKey: "nSpecial")
        News.setValue(newsCreate, forKey: "nCreate")
        News.setValue(newsModify, forKey: "nModify")
        News.setValue(newsRelation, forKey: "nRelation")
        News.setValue(newsRelationName, forKey: "nRelationName")
        News.setValue(newsTime, forKey: "nTime")
        News.setValue(newsTimeStamp, forKey: "nTimeStamp")
        //  print("inserted item id \(newsId)")
        
        do{
            try contextNews.save()
        }catch{
        }
        
    }
    
    func getPF()-> [Dictionary <String, String>]{
        
        var arrayObject:[Dictionary <String, String>] = []
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context01: NSManagedObjectContext = appDel.managedObjectContext
        // select from db
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PortFolio")//NSFetchRequest(entityName: "News")
        request.fetchLimit = 50
        request.predicate = NSPredicate(format: "nSpecial == %@", "0")
        let sortDescriptor = NSSortDescriptor(key: "nTimeStamp", ascending: false)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context01.fetch(request)
            
            
            //        do {
            if (results.count > 0) {
                var i = 0
                for element in results {
                    
                    
                    var id = (element as AnyObject).value(forKey: "nId") as! String
                    var title = (element as AnyObject).value(forKey: "nTitle") as! String
                    var description = (element as AnyObject).value(forKey: "nDescription") as! String
                    var special = (element as AnyObject).value(forKey: "nSpecial") as! String
                    var thumb = (element as AnyObject).value(forKey: "nThumb") as! String
                    var create = (element as AnyObject).value(forKey: "nCreate") as! String
                    var modify = (element as AnyObject).value(forKey: "nModify") as! String
                    var relation = (element as AnyObject).value(forKey: "nRelation") as! String
                    var relationName = (element as AnyObject).value(forKey: "nRelationName") as! String
                    
                    var time = (element as AnyObject).value(forKey: "nTime") as! String
                    // var timestamp = element.valueForKey("nTimeStamp") as! String
                    
                    
                    // print("id from tb \(id)")
                    var dictNewsModel: Dictionary = ["id" : id, "title" : title, "description" : description, "special" : special,
                                                     "thumb" : thumb, "create" : create, "modify" : modify, "relation" :  relation, "time" : time, "nRelationName": relationName]
                    arrayObject.insert(dictNewsModel, at: i)
                    i = i + 1
                }
            } else {
                print("No data")
            }
            
        }catch{
            
        }
        
        
        // select from db
        let requestR = NSFetchRequest<NSFetchRequestResult>(entityName: "PortFolio")//NSFetchRequest(entityName: "News")
        requestR.predicate = NSPredicate(format: "nSpecial == %@", "1")
        let sortDescriptorR = NSSortDescriptor(key: "nTimeStamp", ascending: false)
        let sortDescriptorsR = [sortDescriptorR]
        requestR.sortDescriptors = sortDescriptorsR
        requestR.returnsObjectsAsFaults = false
        
        do{
            let results = try context01.fetch(requestR)
            
            
            //        do {
            if (results.count > 0) {
                var i = 0
                for element in results {
                    
                    
                    var id = (element as AnyObject).value(forKey: "nId") as! String
                    var title = (element as AnyObject).value(forKey: "nTitle") as! String
                    var description = (element as AnyObject).value(forKey: "nDescription") as! String
                    var special = (element as AnyObject).value(forKey: "nSpecial") as! String
                    var thumb = (element as AnyObject).value(forKey: "nThumb") as! String
                    var create = (element as AnyObject).value(forKey: "nCreate") as! String
                    var modify = (element as AnyObject).value(forKey: "nModify") as! String
                    var relation = (element as AnyObject).value(forKey: "nRelation") as! String
                    var relationName = (element as AnyObject).value(forKey: "nRelationName") as! String
                    
                    var time = (element as AnyObject).value(forKey: "nTime") as! String
                    // var timestamp = element.valueForKey("nTimeStamp") as! String
                    
                    
                    // print("id from tb \(id)")
                    var dictNewsModel: Dictionary = ["id" : id, "title" : title, "description" : description, "special" : special,
                                                     "thumb" : thumb, "create" : create, "modify" : modify, "relation" :  relation, "time" : time, "nRelationName": relationName]
                    arrayObject.insert(dictNewsModel, at: i)
                    i = i + 1
                }
            } else {
                print("No data")
            }
            
        }catch{
            
        }
        
        
        
        
        return arrayObject
        
    }

    
    func setToken(_ token: String,uid: String){
        
        
        let session = URLSession.shared
        let url = URL(string: mainUrl+setTokenUrl)!
        let request = NSMutableURLRequest(url: url)
        
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        let postString = "token=\(token)&uid=\(uid)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        DispatchQueue.main.async(execute: {
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    
                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                    print(ipString)
                    
                    UserDefaults.standard.set(true, forKey: "boolTokenSetIntheServer")
                    UserDefaults.standard.set(true, forKey: "boolUniqueId")
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    
                    
                }
                //hide indicator after data is loaded
            })
            task.resume()
        })
        
        
        
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
            
            
            //            session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: NSError?) -> Void in
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    
                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                    print(ipString)
                    
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    
                    
                }
                //hide indicator after data is loaded
            } )
            task.resume()
        })
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
