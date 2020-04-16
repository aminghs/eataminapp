//
//  PortFolioChild.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 8/7/17.
//  Copyright © 2017 ghayeni.ir. All rights reserved.
//


import Foundation
import UIKit
import CoreData

class PortFolioChild: BaseAdapter{
    
//    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pfImage: UIImageView!
    @IBOutlet weak var pfTitle: UILabel!
    @IBOutlet weak var pfDescription: UILabel!
    
    @IBOutlet weak var pfTime: UILabel!
    @IBOutlet weak var pfDatePublished: UILabel!
    @IBOutlet weak var restaurantsTagButton: UIButton!
    
    @IBOutlet weak var pfRelatedR: UILabel!
    
    var nTitle = ""
    var nDescription = ""
    var nDate = ""
    var appCR = "منبع: ایتامین - رستوران های مشهد"
    var appAppstoreUrl = " https://itunes.apple.com/us/app/eatamin-mashhad-restaurants/id1141723477 "
    
    
    @IBOutlet weak var showRestaurantsBtn: UIButton!
    
    @IBAction func share(_ sender: Any) {

        if nTitle.characters.count > 0 && nDescription.characters.count > 0 {
            
            let activityViewController = UIActivityViewController(activityItems:
                ["\(nTitle)  \n\n\(nDescription) \n\(nDate) \n\(appCR) \n#EatAmin \(appAppstoreUrl) "], applicationActivities: nil)
            let excludeActivities = [
                UIActivityType.message,
                UIActivityType.mail,
                UIActivityType.print,
                UIActivityType.copyToPasteboard,
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.addToReadingList,
                UIActivityType.postToFlickr,
                UIActivityType.postToTencentWeibo,
                UIActivityType.airDrop]
            activityViewController.excludedActivityTypes = excludeActivities;
            
            present(activityViewController, animated: true,
                    completion: nil)
            
            
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
      var newsArrayDic:[Dictionary <String, String>] = []
    var rId = ""
    var rName = ""
    
    
    
    @IBAction func showRelatedRestaurants(_ sender: Any) {
    
        
        Shared.shared.restaurantsName = rName
        Shared.shared.restaurantsId = rId
        UserDefaults.standard.set(rId, forKey: "restaurantId")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurantsChild") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        self.present(viewController, animated: false, completion: nil)
        
        
        
    }
    //    @IBAction func ssshowRelatedRestaurants(sender: AnyObject) {
    //
    //
    //
    //        NSUserDefaults.standardUserDefaults().setObject(rId, forKey: "restaurantId")
    //        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RestaurantsChild") as UIViewController
    //        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
    //        self.presentViewController(viewController, animated: false, completion: nil)
    //
    //
    //
    //    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        component().setNavigationBarColorAndFont()
        fadeIn()
        getGesture()
        showRestaurantsBtn.layer.cornerRadius = 5;
        showRestaurantsBtn.layer.masksToBounds = true;
        
        restaurantsTagButton.layer.cornerRadius = 5;
        restaurantsTagButton.layer.masksToBounds = true;
        self.mainView.alpha = 0
        
        
        
        let newsId = UserDefaults.standard.object(forKey: "portfolioId") as! String
        
        
        self.getNews(newsId)
        
        pfTime.layer.cornerRadius = 5
        pfTime.layer.masksToBounds = true
        
        pfDatePublished.layer.cornerRadius = 5
        pfDatePublished.layer.masksToBounds = true
        
        // print(newsId!)
        
        //        newsArrayDic = getNewsById(newsId)
        //        var data  = newsArrayDic[0]
        
        //        newsTitle.text = data["title"]
        //        newsDescription.text = data["description"]
        //        newsDatePublished.text = "تاریخ انتشار : " + data["create"]! + " ساعت " + data["time"]!
        //        if (data["relation"]!).characters.count > 0 {
        //        }
        
        //        if getSpecificImage(data["id"]!){
        //
        //            self.newsImage.image = UIImage(data: getSpecifiImageFromDb(data["id"]!))
        //
        //        }else{
        //
        //
        //            // get data of the image
        //            let url = NSURL(string: "http://todayrate.ir/files/Untitled-1.jpg")
        //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        //                let imageData = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        //                dispatch_async(dispatch_get_main_queue(), {
        //
        //
        //                    let temp: Bool = self.getSpecificImage(data["id"]!)
        //                    if !temp {
        //                        self.insertDataIntoCacheImage(data["id"]!,imageData: imageData!)
        //                    }
        //                    self.newsImage.image = UIImage(data: imageData!)//UIImage(data: data!)
        //                });
        //            }
        //
        //
        //
        //        }
        
        //        if data["relation"]?.characters.count>0 {
        //            newsRelatedR.text = "مربوط به  " + data["relationname"]!
        //            rId  = data["relation"]!
        //            //print("rId = " + rId)
        //            showRestaurantsBtn.setTitle("#"+data["relationname"]!, forState: UIControlState.Normal)
        //        }else{
        //            newsRelatedR.alpha = 0
        //            showRestaurantsBtn.alpha = 0
        //        }
        
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CacheImage")//NSFetchRequest(entityName: "CacheImage")
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
                //print("Found")
                
            } else {
                print("NotFound")
            }
            
            
            
            
            
        }catch{
            
        }
        
        
        return imageData
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Insert your save data statements in this function
        print("Insert your save data statements in this function")
    }
    
    
    /*get gesture*/
    
    
    func getGesture(){
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(NewsChild.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(NewsChild.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        
    }
    
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                //print("Swiped right")
                switchScreen(1)
                
                break
            case UISwipeGestureRecognizerDirection.down:
                //print("Swiped down")
                break
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                break
            case UISwipeGestureRecognizerDirection.up:
                //print("Swiped up")
                break
            default:
                break
            }
        }
    }
    
    
    func switchScreen(_ position: Int) {
        switch(position){
            
        case 1 :
            fadeOut()
            self.performSegue(withIdentifier: "closeNewsChild", sender: "")
            
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
        
        
    }
    
    /* */
    
    func fadeIn() {
        //        // Move our fade out code from earlier
        //        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
        //            self.mainView.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        //            }, completion: nil)
    }
    
    
    func fadeOut() {
        //        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
        //            self.mainView.alpha = 0.0
        //            }, completion: nil)
    }
    
    /*get news from internet */
    func getNews(_ id: String) {
        
        var arrayObject:[Dictionary <String, String>] = []
        
        
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.alpha = 1
        
        var isDataAvailable = false;
        let session = URLSession.shared
        let url = URL(string: portFolioUrl)!
        
        let request = NSMutableURLRequest(url: url)
        //request.setValue("clientIDhere", forHTTPHeaderField: "Authorization")
        //request.addValue("clientIDhere", forHTTPHeaderField: "Authorization")
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        let postString = "id=\(id)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.alpha = 0
                    
                    return
                }
                
                
                
                do {
                    
                    if let newsString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                        print(newsString)
                        
                        arrayObject = self.parseNewsArray(data!)
                        if arrayObject.count > 0 {
                            isDataAvailable = true
                        }
                        
                    }
                    
                }catch{
                    
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.alpha = 0
                    
                    if isDataAvailable {
                        
                        self.newsArrayDic = arrayObject
                        var data  = self.newsArrayDic[0]
                        
                        self.pfTitle.text = data["title"]
                        self.nTitle = data["title"]!
                        self.pfDescription.text = data["description"]
                        self.nDescription = data["description"]!
                        self.pfDatePublished.text = data["create"]!
                        self.pfTime.text = " ساعت " + component().changeFormat(data["time"]!)
                        self.nDate = "تاریخ انتشار : " + data["create"]! + " ساعت " + data["time"]!
                        
                        do{
                            if "1" != data["thumb"] as String! {
                                let imageView = self.pfImage
                                let URL1 = URL(string: data["thumb"]!)!
                                let placeholderImage = UIImage(named: "defaults.jpg")!
                                print(URL1)
                                imageView?.af_setImage(withURL: URL1, placeholderImage: placeholderImage)
                            }else{
                                self.pfImage.image = UIImage(named: "defaults.jpg")!
                            }
                        }catch{
                            print("image is null!")
                            self.pfImage.image = UIImage(named: "defaults.jpg")!
                        }
                        
                        //                        do{
                        
                        if  let relation = data["relation"] as String! {
                            if relation.characters.count > 0 {
                                self.pfRelatedR.text = "مرتبط با " //+ data["nRelationName"]!
                                self.rId  = data["relation"]!
                                self.rName = data["nRelationName"]!
                                //print("rId = " + rId)
                                self.showRestaurantsBtn.setTitle("#"+data["nRelationName"]!, for: UIControlState())
                                self.showRestaurantsBtn.alpha = 0
                                
                                self.restaurantsTagButton.setTitle("#"+data["nRelationName"]!, for: UIControlState())
                            }else{
                                self.restaurantsTagButton.alpha = 0
                                self.pfRelatedR.alpha = 0
                                self.showRestaurantsBtn.alpha = 0
                                
                            }
                        }
                        
                        
                        self.mainView.alpha = 1.0
                        
                    }else{
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                //hide indicator after data is loaded
            })
            task.resume()
            
        })
        
        
        
    }
    //*************
    func parseNewsArray(_ data: Data)-> [Dictionary <String, String>]{
        
        var arrayObject:[Dictionary <String, String>] = []
        
        
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
                
                var i = 0
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
                    
                    var dictNewsModel: Dictionary = ["id" : nId, "title" : nTitle, "description" : nDescription, "special" : nSpecial, "thumb" : nThumb, "create" : nCreate, "modify" : nModify, "relation" :  nRelation, "time" : nTime, "nRelationName": nRelationName]
                    arrayObject.insert(dictNewsModel, at: i)
                    i = i + 1
                    
                    
                    
                    
                    
                }
                
            }
            
            
        }catch{
            
            arrayObject = []
            
        }
        return arrayObject
    }
    
    
}
