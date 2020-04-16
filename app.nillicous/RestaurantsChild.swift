//
//  RestaurantsChild.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/24/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Auk
import Cosmos
import MapKit

class RestaurantsChild: BaseAdapter{
    
//    @IBOutlet weak var scrollview: UIScrollView!
//    @IBOutlet weak var mainView: UIView!
//    @IBOutlet weak var rankImage: UIImageView!
//    @IBOutlet weak var restaurantName: UILabel!
//    @IBOutlet weak var restaurantsDescription: UILabel!
//    @IBOutlet weak var rDescriptionHeight: NSLayoutConstraint!
 //   @IBOutlet weak var scrollview: UIScrollView!
   
    @IBOutlet weak var retaurantOnMap: MKMapView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantDescription: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var restaurantsDesConstraint: NSLayoutConstraint!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var restaurantsAddress: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tell: UILabel!
    @IBOutlet weak var scheduleTime: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var showMenuBtn: UIButton!
    @IBOutlet weak var reserveBtn: UIButton!
    @IBOutlet weak var reserveBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var labelOneHeight: NSLayoutConstraint!
    @IBOutlet weak var labelTwoHeight: NSLayoutConstraint!
    @IBOutlet weak var labelThreeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var restaurantsAddConstraint: NSLayoutConstraint!
    var rId = ""
    var rName = ""
    var rDescription = ""
    var rAddress = ""
    var rRank = ""
    var rImage1 = ""
    var rImage2 = ""
    var rImage3 = ""
    var rSpecial = ""
    var rMorning = ""
    var rNoon = ""
    var rNight = ""
    var rModify = ""
    var rReserve = ""
    var rTell = ""
    var rLat = ""
    var rLang = ""
    var appCR = "منبع: ایتامین - رستوران های مشهد"
    var appAppstoreUrl = " https://itunes.apple.com/us/app/eatamin-mashhad-restaurants/id1141723477 "
    var shiftAvailable = false
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    @IBAction func share(_ sender: AnyObject) {
        
        if rName.characters.count > 0 && rId.characters.count > 0 {
        
        let activityViewController = UIActivityViewController(activityItems:
            ["\(rName) \n\(rAddress) \n\(rTell) \n\(appCR) \n#EatAmin \n\(appAppstoreUrl) "], applicationActivities: nil)
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
    
    
    @IBAction func unwindToThisViewController(_ segue: UIStoryboardSegue) {
         // print("Returned from detail screen")
        //UITabBar.appearance().alpha = 1
        
    }
    
    @IBAction func openMenuOfTheRestaurants(_ sender: AnyObject) {
        
      
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurantsMenu") as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
        
        
    }
    
    @IBAction func showReserveRestaurants(_ sender: AnyObject) {
        
        
        
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReserveRestaurants") as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
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
        
        let restaurantId = UserDefaults.standard.object(forKey: "restaurantId") as! String
        
        //print(restaurantId)
       

        loadingIndicator.startAnimating()
        loadingIndicator.alpha = 1
        getSpecificRestaurant(restaurantId)
        
        showMenuBtn.layer.cornerRadius = 15;
        showMenuBtn.layer.masksToBounds = true;

        reserveBtn.layer.cornerRadius = 15;
        reserveBtn.layer.masksToBounds = true;
        
        
        self.scrollview.auk.settings.preloadRemoteImagesAround = 1
        self.scrollview.auk.startAutoScroll(delaySeconds: 3)
        self.scrollview.auk.settings.placeholderImage = UIImage(named: "defaults.jpg")

        
        Shared.shared.reserveResDay = nil
        Shared.shared.reserveResMonth = nil
        Shared.shared.reserveResYear = nil
        Shared.shared.selectedDateTitle = nil

      
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        if !(annotation is MKPointAnnotation) {
//            return nil
//        }
//        
//        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("demo")
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "demo")
//            annotationView!.canShowCallout = true
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//        
//        annotationView!.image = UIImage(named: "restaurants")
//        
//        return annotationView
//        
//    }

    /**/

    
    
 
    func getSpecificRestaurant(_ id: String){
        
        
        let session = URLSession.shared
       // let postEndpoint: String = "http://todayrate.ir/index.php/api/restaurants"
        let url = URL(string: mainUrl+restaurantUrl)!
        
        let request = NSMutableURLRequest(url: url)
        //request.setValue("clientIDhere", forHTTPHeaderField: "Authorization")
        //request.addValue("clientIDhere", forHTTPHeaderField: "Authorization")
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        let postString = "id=\(id)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        DispatchQueue.main.async(execute: {
            
            
                let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in

                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    
                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                    // print(ipString)
                    
                    
                    self.parseRestaurantJsonArray(data!)
                    
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    

                    if "1" != self.rReserve {
                      self.reserveBtn.alpha  = 0
                      self.reserveBtnHeight.constant = 0
                     }
                    
                    
                    if self.rImage1.characters.count > 6 {
                        // Show remote images
                        self.scrollview.auk.show(url: mainUrlThumb+self.rImage1)
                       // print(mainUrlThumb+self.rImage1)
                    }
                    if self.rImage2.characters.count > 6 {
                        // Show remote images
                        self.scrollview.auk.show(url: mainUrlThumb+self.rImage2)
                    }
                    if self.rImage3.characters.count > 6 {
                        // Show remote images
                        self.scrollview.auk.show(url: mainUrlThumb+self.rImage3)
                    }
                    

                    

                    if self.rRank == "0" || self.rRank == "۰" || self.rRank == "" {
                        //cell.crRankStatus?.text = "بررسی انجام نشده است."
                        
                        self.cosmosView.rating = 0
                        
                        
                    }else if self.rRank == "1" || self.rRank == "۱" {
                        //  self.rankImage?.image  = UIImage(named: "onestar")
                        //cell.crRestaurantRateImage.alpha = 1
                        
                        self.cosmosView.rating = 1
                        
                    }else if self.rRank == "2" || self.rRank == "۲" {
                        //self.rankImage?.image  = UIImage(named: "twostar")
                        //cell.crRestaurantRateImage.alpha = 1
                        
                        self.cosmosView.rating = 2
                        
                    }else if self.rRank == "3" || self.rRank == "۳" {
                        //self.rankImage?.image  = UIImage(named: "threestar")
                        self.cosmosView.rating = 3
                        //cell.crRestaurantRateImage.alpha = 1
                    }
                    
                   // self.cosmosView.rating = 2
                    self.cosmosView.settings.updateOnTouch = false
                    self.restaurantName?.text = self.rName
                    self.restaurantDescription?.text = self.rDescription
                //    self.restaurantsDesConstraint.constant = component().heightForView(self.rDescription,label: self.restaurantDescription)
                    self.restaurantsAddress?.text = self.rAddress
                //    self.restaurantsAddConstraint.constant = component().heightForView(self.rAddress,label: self.restaurantsAddress)
                    self.mainView.alpha = 1
                    
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.alpha = 0
                    
                  
                    if self.rMorning.characters.count >= 4 {
                        self.label1?.text =  component().changeFormat(self.rMorning)
                        self.shiftAvailable = true
                    }else{
                        self.label1?.text =  " "
//                        self.label1.alpha = 0
//                        self.labelOneHeight.constant = 0
                    }
                    
                    if self.rNoon.characters.count >= 4 {
                        self.label2?.text =  component().changeFormat(self.rNoon)
                        self.shiftAvailable = true

                    }else{
                        self.label2?.text = " "
//                        self.label2.alpha = 0
//                        self.labelTwoHeight.constant = 0
                    }
                    
                    if self.rNight.characters.count >= 4 {
                        self.label3?.text =  component().changeFormat(self.rNight)
                        self.shiftAvailable = true
                    }else{
                        self.label3?.text =  " "
//                        self.label3.alpha = 0
//                        self.labelThreeHeight.constant = 0
                    }
                    
                    if self.shiftAvailable {
                        self.scheduleTime?.text = "ساعت کاری:"
                    }else{
                        self.scheduleTime?.text = "ساعت کاری تعریف نشده"
                    }
                    
                    if self.rTell.characters.count > 0 {
                    
                        self.tell?.text = component().changeFormat(self.rTell)
                        
                    }else{
                        
                        self.tell?.text = "شماره تماس ثبت نشده"
                    
                    }
                    do{
                        
                        
                    if self.rLang.characters.count > 0 && self.rLat.characters.count > 0 {
                        
                    let location = CLLocationCoordinate2D(latitude: Double(self.rLat)!, longitude: Double(self.rLang)!)
                    let region = MKCoordinateRegionMakeWithDistance(location, 800.0, 1500.0)
                    self.retaurantOnMap.setRegion(region, animated: true)
                   
                
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.rName
                    self.retaurantOnMap.addAnnotation(annotation)
                        
//                        let annotation = ColorPointAnnotation(UIColor.blueColor())
//                        annotation.coordinate = location
//                        annotation.title = "title"
//                        annotation.subtitle = "subtitle"
//                         self.retaurantOnMap.addAnnotation(annotation)
                    
                    }else{
                        
                    let location = CLLocationCoordinate2D(latitude: 36.294024, longitude: 59.610181)
                    let region = MKCoordinateRegionMakeWithDistance(location, 800.0, 1500.0)
                    self.retaurantOnMap.setRegion(region, animated: true)

                   //let annotation = MKPointAnnotation()
                   //annotation.coordinate = location
                   //self.retaurantOnMap.addAnnotation(annotation)
                   // self.retaurantOnMap.centerCoordinate = location
                   // let annotation = MKPlacemark().
                   // self.retaurantOnMap
  
                    }
                    }catch{
                        
                    }

                   
                    
                }
                //hide indicator after data is loaded
                })
            task.resume()
            
        })
        
        
        
    }
    
    func parseRestaurantJsonArray(_ data: Data){
        
        
        do{
            
            let arr = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if let restaurantArray = arr as? [[String: AnyObject]]{
                
                
                
//                var rId = ""
//                var rName = ""
//                var rDescription = ""
//                var rAddress = ""
//                var rRank = ""
//                var rImage1 = ""
//                var rImage2 = ""
//                var rImage3 = ""
//                var rSpecial = ""
//                var rMorning = ""
//                var rNoon = ""
//                var rNight = ""
//                var rModify = ""
                
                for rData in restaurantArray {

                    /*its important to clear the food table before parsing the json*/
                    self.emptyTheFoodsTB()

                    
                    
                    
                    if let datal1 = rData["id"] as? String {
                        rId = datal1
                    }
                    
                    if let datal1 = rData["name"] as? String {
                        rName = datal1
                    }
                    
                    if let datal1 = rData["tell"] as? String  {
                        rTell = datal1
                    }
                    
                    if let datal1 = rData["latitude"] as? String {
                        rLat = datal1
                    }
                    
                    if let datal1 = rData["longitude"] as? String {
                        rLang = datal1
                    }
                    
                    if let datal1 = rData["description"] as? String {
                        rDescription = datal1
                    }
                    
                    if let datal1 = rData["address"] as? String {
                        rAddress = datal1
                    }
                    
                    if let datal1 = rData["rank"] as? String {
                        rRank = datal1
                    }
                    
                    if let datal1 = rData["image1"] as? String {
                        rImage1 = datal1
                    }
                    
                    if let datal1 = rData["image2"] as? String {
                        rImage2 = datal1
                    }
                    
                    if let datal1 = rData["image3"] as? String {
                        rImage3 = datal1
                    }
                    
                    if let datal1 = rData["special"] as? String {
                        rSpecial = datal1
                    }
                    
                    if let datal1 = rData["morning"] as? String {
                        rMorning = datal1
                    }
                    
                    if let datal1 = rData["noon"] as? String {
                        rNoon = datal1
                    }
                    if let datal1 = rData["night"] as? String {
                        rNight = datal1
                    }
                    if let datal1 = rData["modify"] as? String {
                        rModify = datal1
                    }
                    if let reserve = rData["reserveEnable"] as? String{
                        rReserve = reserve
                    }
                    
                    //print(getSpecificRestaurants(rId))
                    
                    if let groups = rData["group"] as? [AnyObject] {
                        
                        
                        for group in groups {
                            
                            if let _ = group["name"] as? String{
                                // print()
                                
                            }
                            
                            if let assets = group["assets"] as? [AnyObject] {
                                
                                for asset in assets {
                                    
                                    var fid = ""
                                    var fname = ""
                                    var fprice = ""
                                    var funit = ""
                                    var fshift = ""
                                    var fDescription = ""
                                    
                                    if let datal2 = asset["id"] as? String{
                                        fid = datal2
                                    }
                                    if let datal2 = asset["name"] as? String{
                                        fname = datal2
                                    }
                                    if let datal2 = asset["price"] as? String{
                                        fprice = datal2
                                    }
                                    if let datal2 = asset["unit"] as? String{
                                        funit = datal2
                                    }
                                    if let datal2 = asset["shift"] as? String{
                                        fshift  = datal2
                                    }
                                    if let datal2 = asset["description"] as? String{
                                        fDescription  = datal2
                                    }
                                    
                                    //fDescription
                                    //print(getSpecificFoods(fid ,rId: rId))
                                    
                                    //setUpCoreData
                                    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let contextNews: NSManagedObjectContext = appDel.managedObjectContext
                                    // insert into db
                                    let News = NSEntityDescription.insertNewObject(forEntityName: "Foods", into: contextNews)
                                    News.setValue(fid, forKey: "fId")
                                    News.setValue(fname, forKey: "fName")
                                    News.setValue(fprice, forKey: "fPrice")
                                    News.setValue(funit, forKey: "fUnit")
                                    News.setValue(fshift, forKey: "fShift")
                                    News.setValue(fDescription, forKey: "fDescription")
                                    News.setValue(rId, forKey: "rId")

                                    do{
                                        try contextNews.save()
                                    }catch{
                                    }

                                    
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                    
                        
                    }
                    
                    
                }
                
            }
            
            
        }catch{
            
            
        }
        
    }

    func getSpecificRestaurants(_ id: String)-> Bool{
        
        var idIsFounded = false
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context01: NSManagedObjectContext = appDel.managedObjectContext
        // select from db
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurants")//NSFetchRequest(entityName: "Restaurants")
        request.predicate = NSPredicate(format: "rId == %@", id)
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
    
//    func getSpecificFoods(fId: String, rId: String)-> Bool{
//        
//        var idIsFounded = false
//        
//        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context01: NSManagedObjectContext = appDel.managedObjectContext
//        // select from db
//        let request = NSFetchRequest(entityName: "Foods")
//        request.predicate = NSPredicate(format: "rId == %@", rId)
//        request.predicate = NSPredicate(format: "fId == %@", fId)
//        request.returnsObjectsAsFaults = false
//        
//        do{
//            let results = try context01.executeFetchRequest(request)
//            
//            
//            do {
//                if (results.count > 0) {
//                    
//                    idIsFounded =  true
//                    return idIsFounded
//                    //   print("Found")
//                    
//                } else {
//                    //   print("NotFound")
//                }
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
//        return idIsFounded
//    }

    func emptyTheFoodsTB(){
        
//        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDel.managedObjectContext
//        do{
//            let request = NSFetchRequest(entityName: "Foods")
//            var myList = try context.executeFetchRequest(request)
//            
//            var bas: NSManagedObject!
//            for bas: AnyObject in myList
//            {
//                context.deleteObject(bas as! NSManagedObject)
//            }
//            myList.removeAll(keepCapacity: false)
//            
//            try context.save()
//            
//        }catch{
//            
//        }

        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Foods")//NSFetchRequest(entityName: "Foods")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.execute(deleteRequest, with: context)
        } catch let error as NSError {
            debugPrint(error)
        }
        
//        let fetchRequest = NSFetchRequest(entityName: "Foods")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        do {
//            try myPersistentStoreCoordinator.executeRequest(deleteRequest, withContext: context)
//        } catch let error as NSError {
//            // TODO: handle the error
//        }
        
        
        

        
    }
}
    

    

