//
//  File.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/12/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AlamofireImage



extension Dictionary {
    mutating func merge<K, V>(_ dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}


class News : BaseAdapter, UITableViewDelegate {
    
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var internetStatusView: UIView!
    @IBAction func deleteDb(_ sender: AnyObject) {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
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
    @IBOutlet weak var newsTableView: UITableView!
    var newsArrayDic:[Dictionary <String, String>] = []
    var newsArrayDicR:[Dictionary <String, String>] = []
    let cache = NSCache<AnyObject, AnyObject>()//NSCache()
    
   
    
    
    // add this function. When the detail ViewController is unwound, it executes this
    // function
    
    @IBAction func unwindToThisViewController(_ segue: UIStoryboardSegue) {
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
        
        
       //UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.blueColor(), size: CGSizeMake(UITabBar.frame.width/5, UITabBar.frame.height))
        

        
        
       // UITabBarItem.appearance()
        newsArrayDic = getNewsTb()
        refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(News.refresh(_:)), for: UIControlEvents.valueChanged)
        newsTableView.addSubview(refreshControl) // not required when using UITableViewController
        

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
            getNews()
        }else{
            self.refreshControl.endRefreshing()
            self.internetStatusView.alpha = 1
            
        }
        
    }
    
    func refresh(_ sender:AnyObject) {
    
        if Reachability.isConnectedToNetwork() {
            getNews()
        }else{
            self.refreshControl.endRefreshing()
            self.internetStatusView.alpha = 1
            
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        newsTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return newsArrayDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        
       
      
        var cellIdentifier =  "newsCustomRow"
        if component().isIphone(){
             cellIdentifier =  "newsCustomRow"
        }else{
             cellIdentifier =  "newsCustomRow2"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! newsCustomRow
        var data  = newsArrayDic[(indexPath as NSIndexPath).row]
        cell.newsTitle?.text = data["title"]
        //cell.moreData?.text = "اطلاعات بیشتر"
        cell.newsBody?.text = data["description"]
        cell.newsDate?.text = data["create"]
        
        cell.newsDate?.layer.cornerRadius = 5
        cell.newsDate?.layer.masksToBounds = true

      //  cell.newsImage?.image = UIImage(named: "defaults.jpg")
      
//        if getSpecificImage(data["id"]!){
//           // cell.newsImage.image = UIImage(data: getSpecifiImageFromDb(data["id"]!))
//        }else{
//            // get data of the image
//            //cell.newsImage.image = nil
//            if "1" != data["thumb"] as String! {
//                let url = NSURL(string: data["thumb"]!)
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                    let imageData = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//                    dispatch_async(dispatch_get_main_queue(), {
//                        
//                        
//                        let temp: Bool = self.getSpecificImage(data["id"]!)
//                        if !temp {
//                            self.insertDataIntoCacheImage(data["id"]!,imageData: imageData!)
//                        }
//                    });
//                }
//
//                
//            }else{
//                
//                 cell.newsImage.image = UIImage(named: "defaults.jpg")!
//            }
//          }
        //Alamofire.request(.GET, data["thumb"]!).responseImage { response in debugPrint(response)
       // print(data["thumb"]!)
        
        
        do{
        if "1" != data["thumb"] as String! {
        let imageView = cell.newsImage
        let URL = Foundation.URL(string: data["thumb"]!)!
        let placeholderImage = UIImage(named: "defaults.jpg")!
            imageView?.af_setImage(withURL: URL, placeholderImage: placeholderImage)
        }else{
            cell.newsImage.image = UIImage(named: "defaults.jpg")!
            }
        }catch{
            print("image is null!")
            cell.newsImage.image = UIImage(named: "defaults.jpg")!
        }
        
        
//        let downloader = ImageDownloader()
//        let URLRequest = NSURLRequest(URL: NSURL(string: data["thumb"]!)!)
//        
//        downloader.downloadImage(URLRequest: URLRequest) { response in
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//            
//            if let image1 = response.result.value {
//                cell.newsImage.image = image1
//            }
//        }
//        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        
        
        
        return cell
    }
    
    func insertDataIntoCacheImage(_ id: String, imageData: Data){
        
        //setUpCoreData
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
        
        // insert into db
        let News = NSEntityDescription.insertNewObject(forEntityName: "CacheImage", into: contextNews)
        News.setValue(id, forKey: "cImageId")
        News.setValue(imageData, forKey: "cImageData")
        
        print("inserted item id in cacheed image \(id)")
        
        do{
            try contextNews.save()
        }catch{
        }
        
    }
    
    func getSpecificImage(_ id: String)-> Bool{
        
        var idIsFounded = false
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context01: NSManagedObjectContext = appDel.managedObjectContext
        // select from db
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CacheImage")//NSFetchRequest(entityName: "CacheImage")
        request.predicate = NSPredicate(format: "cImageId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context01.fetch(request)
            
            
            do {
                if (results.count > 0) {
                    
                    idIsFounded =  true
                    return idIsFounded
                   // print("Found")
                    
                } else {
                   print("NotFound")
                }
                
                
                
            } catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
            
            
            
        }catch{
            
        }
        
        
        return idIsFounded
    }
    
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
        
        var data  = newsArrayDic[(indexPath as NSIndexPath).row]
       //  NSLog("You selected cell id: \(data["id"]!)")
        
        
        //self.performSegueWithIdentifier("NewsChild", sender: self)
        
        UserDefaults.standard.set(data["id"]!, forKey: "newsId")
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsChild") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        self.present(viewController, animated: false, completion: nil)

        
    }
    
    func getNews(){
        
        var isDataAvailable = false;
        self.internetStatusView.alpha = 0
        let session = URLSession.shared
        let url = URL(string: mainUrl+newsUrl)!
        
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
                        
                        self.parseJsonArray(data!)
                        isDataAvailable = true
                        
                    }
                    
                }catch{
                    
                    
                }
                
                
                DispatchQueue.main.async {
                   
                   
                    if isDataAvailable {
                        
                    self.refreshControl.endRefreshing()
                    self.newsArrayDic = []
                    self.newsArrayDic = self.getNewsTb()
                    self.newsTableView.reloadData()

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
