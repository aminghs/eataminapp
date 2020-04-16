//
//  Search.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/31/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit

class Search: UIViewController, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var resultForSubject: UILabel!
    @IBOutlet weak var searchWithNoResult: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var restaurantListObject:[Dictionary <String, String>] = []
   // @IBOutlet weak var searchEditText: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    var sectionName = ""
    let sectionFoodName = "asset"
    let sectionRestaurantName = "restaurant"
    let sectionAddress = "address"
    
    /* pl = place holder */
    let sectionFoodNamePL = "نام غذا"
    let sectionRestaurantNamePL = "نام رستوران"
    let sectionAddressPL = "آدرس رستوران"
    
    var sectionNameFa = ""
    let session = URLSession.shared

    
    @IBOutlet weak var searchableTextField: UITextField!
    
    @IBAction func searchAction(_ sender: AnyObject) {
        
        if let keyword = self.searchableTextField.text {
            getSpecificRestaurant(sectionName, keyword: keyword)
            self.searchableTextField.resignFirstResponder()
            }
        

        self.searchableTextField.resignFirstResponder()
        
        getClearTable()
        
    }
  
   /* choose section name */
    
    @IBOutlet weak var restaurantSearchSubjectBtn: UIButton!
    @IBAction func restaurantSearchSubject(_ sender: AnyObject) {
        
        self.searchableTextField.text = ""
        self.searchableTextField.placeholder = sectionRestaurantNamePL
        sectionName = sectionRestaurantName
        sectionNameFa = sectionRestaurantNamePL
        

        
        self.foodSearchSubjectBtn.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.foodSearchSubjectBtn.layer.borderWidth = 0
        self.foodSearchSubjectBtn.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
      
        self.addressSearchSubject.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.addressSearchSubject.layer.borderWidth = 0
        self.addressSearchSubject.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())

        
        self.restaurantSearchSubjectBtn.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.restaurantSearchSubjectBtn.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        


        
    }
    
    @IBOutlet weak var addressSearchSubject: UIButton!
    @IBAction func addressSearchSubject(_ sender: AnyObject) {
        
        self.searchableTextField.text = ""
        self.searchableTextField.placeholder = sectionAddressPL
        sectionName = sectionAddress
        sectionNameFa = sectionAddressPL

        
        
        self.foodSearchSubjectBtn.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.foodSearchSubjectBtn.layer.borderWidth = 0
        self.foodSearchSubjectBtn.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        
        self.addressSearchSubject.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.addressSearchSubject.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        

        
        
        self.restaurantSearchSubjectBtn.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.restaurantSearchSubjectBtn.layer.borderWidth = 0
        self.restaurantSearchSubjectBtn.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        


        
    }
    
    @IBOutlet weak var foodSearchSubjectBtn: UIButton!
    @IBAction func foodSearchSubject(_ sender: AnyObject) {
        
        self.searchableTextField.text = ""
        self.searchableTextField.placeholder = sectionFoodNamePL
        sectionName = sectionFoodName
        sectionNameFa = sectionFoodNamePL

        self.foodSearchSubjectBtn.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.foodSearchSubjectBtn.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        
        
        self.addressSearchSubject.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.addressSearchSubject.layer.borderWidth = 0
        self.addressSearchSubject.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
  

        self.restaurantSearchSubjectBtn.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.restaurantSearchSubjectBtn.layer.borderWidth = 0
        self.restaurantSearchSubjectBtn.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
      

    }
    
    @IBAction func unwindToThisViewController(_ segue: UIStoryboardSegue) {
        print("Returned from detail screen")
        UITabBar.appearance().alpha = 1
        
    }
    
    func getBorderColor() -> CGColor {
        
        return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1).cgColor
    }
    
    func getClearTable(){
        self.searchableTextField.resignFirstResponder()
        self.searchableTextField.text = ""
        self.searchTableView.alpha = 0
        self.restaurantListObject = []
    }
    

    /* search Button clicked */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        getClearTable()
        if let keyword = searchBar.text {
            
                        getSpecificRestaurant(sectionName, keyword: keyword)
                    }
        searchBar.resignFirstResponder()
        
    }
    
    /* text field search button clicked */


    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
    
        if let keyword = textField.text {
            /**/
            let toArray = keyword.components(separatedBy: "ك")
            let backToString = toArray.joined(separator: "ک")
            
            let toArray1 = backToString.components(separatedBy: "ي")
            let backToString1 = toArray1.joined(separator: "ی")
            
            /**/
        getSpecificRestaurant(sectionName, keyword: backToString1)
        }
        textField.resignFirstResponder()

        
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getClearTable()
        self.setDefault()
       

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       

        let maskPath = UIBezierPath(roundedRect: self.restaurantSearchSubjectBtn.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.restaurantSearchSubjectBtn.layer.mask = shape
        self.restaurantSearchSubjectBtn.layer.masksToBounds = true
        
        
        let maskPathNoon = UIBezierPath(roundedRect: self.foodSearchSubjectBtn.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shapeNight = CAShapeLayer()
        shapeNight.path = maskPathNoon.cgPath
        self.foodSearchSubjectBtn.layer.mask = shapeNight
        self.foodSearchSubjectBtn.layer.masksToBounds = true

        
    }
    
 
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     
        return restaurantListObject.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        //let cellIdentifier =  "searchCustomRow"
        let cellIdentifier =  "searchCustomRow1"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! searchCustomRow
        
        
        var data  = restaurantListObject[(indexPath as NSIndexPath).row]
        //cell.newsTitle?.text = data["title"]
        cell.crRestaurantName?.text = data["name"]
        
        cell.crRestaurantThumbnail?.layer.cornerRadius = 15
        cell.crRestaurantThumbnail?.layer.masksToBounds = true
        
        var temp = ""
        temp = data["thumb"]!
        if temp.characters.count > 3 {
//            // get data of the image
//            let url = NSURL(string: mainUrlThumb+temp)
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                let imageData = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//                dispatch_async(dispatch_get_main_queue(), {
//                    cell.crRestaurantThumbnail?.image = UIImage(data: imageData!)//UIImage(data: data!)
//                });
//            }
            
            let imageView = cell.crRestaurantThumbnail
            let URL = Foundation.URL(string: mainUrlThumb+temp)!
            let placeholderImage = UIImage(named: "defaults2.jpg")!
            imageView?.af_setImage(withURL: URL, placeholderImage: placeholderImage)

            
        }
        
       
        
        do{
            
            var rank = ""
            rank = data["rank"]!
            
            if rank == "0" || rank == "۰" || rank == "" {
                cell.crRestaurantRank.alpha = 0
                cell.crRankStatus.text = "بدون ستاره"
                cell.crRankStatus.alpha = 1
            }else if rank == "1" || rank == "۱" {
                cell.crRankStatus.alpha = 0
                cell.crRestaurantRank.rating = 2//1
                cell.crRestaurantRank.settings.updateOnTouch = false
                cell.crRestaurantRank.alpha = 1
                
                //                cell.crRestaurantRateImage?.image  = UIImage(named: "onestar")
                //                cell.crRestaurantRateImage.alpha = 1
                
            }else if rank == "2" || rank == "۲" {
                cell.crRankStatus.alpha = 0
                cell.crRestaurantRank.rating = 1//2
                cell.crRestaurantRank.settings.updateOnTouch = false
                cell.crRestaurantRank.alpha = 1
                
                
                //                cell.crRestaurantRateImage?.image  = UIImage(named: "twostar")
                //                cell.crRestaurantRateImage.alpha = 1
                
            }else if rank == "3" || rank == "۳" {
                cell.crRankStatus.alpha = 0
                cell.crRestaurantRank.rating = 0 //3
                cell.crRestaurantRank.settings.updateOnTouch = false
                cell.crRestaurantRank.alpha = 1
                
                
                //                cell.crRestaurantRateImage?.image  = UIImage(named: "threestar")
                //                cell.crRestaurantRateImage.alpha = 1
            }
            
            
            
        }catch{
            cell.crRankStatus?.text = "برای این رستوران بررسی انجام نشده است."
        }

        

        cell.selectionStyle = UITableViewCellSelectionStyle.none

        
        return cell
    }
    
    func getSpecificRestaurant(_ section: String, keyword: String){
        
        self.searchTableView.alpha = 0
        self.loadingIndicator.alpha = 1
        
        self.searchWithNoResult.alpha = 0
        self.searchWithNoResult?.text = ""
        self.resultForSubject?.text = ""
        self.resultForSubject.alpha = 0
        
        self.loadingIndicator.startAnimating()
        
        
        let url = URL(string: mainUrl+searchURL)!
        
        let request = NSMutableURLRequest(url: url)
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        let postString = "section=\(section)&keyword=\(keyword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        DispatchQueue.main.async(execute: {
            
            
            self.session.finishTasksAndInvalidate()
            self.session.invalidateAndCancel()
           
//            self.session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: NSError?) -> Void in
            let task = self.session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in

                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    
                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                    // print(ipString)
                    
                    
                  self.restaurantListObject = self.parseRestaurantsJsonArray(data!)
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    if self.restaurantListObject.count > 0 {
                    self.searchTableView.reloadData()
                    self.searchTableView.alpha = 1
                    self.resultForSubject.text = "نتیجه یافت شده برای ' \(keyword) '"
                        self.resultForSubject.alpha = 1

                        
                    }else{
                        self.searchWithNoResult.alpha = 1
                        self.searchWithNoResult?.text = "نتیجه ای برای ' \(keyword) ' در دسته بندی ' \(self.sectionNameFa) ' یافت نشد."
                    }
                    self.loadingIndicator.alpha = 0
                    self.loadingIndicator.stopAnimating()
                    
                }
                //hide indicator after data is loaded
                } )
            task.resume()
            
        })
        
        
        
    }
    
    func parseRestaurantsJsonArray(_ data: Data)-> [Dictionary <String, String>]{
        
        var arrayObject:[Dictionary <String, String>] = []
        
        
        do{
            
            let arr = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if let newsArray = arr as? [[String: AnyObject]]{
                
                
                
                var rId = ""
                var rName = ""
                var rRank = ""
                var rThumb = ""
                var rSpecial = ""
                var rModify = ""
                
                
                
                var i = 0
                
                for restaurant in newsArray {
                    
                    
                    if let id = restaurant["id"] as? String {
                        rId = id
                    }
                    
                    if let name = restaurant["name"] as? String {
                        rName = name
                    }
                    
                    if let rank = restaurant["rank"] as? String {
                        rRank = rank
                    }
                    
                    if let thumb = restaurant["thumb"] as? String {
                        rThumb = thumb
                    }
                    
                    if let special = restaurant["special"] as? String{
                        rSpecial = special
                    }
                    
                    if let modify = restaurant["modify"] as? String{
                        rModify = modify
                    }
                    
                    let dictNewsModel: Dictionary = ["id" : rId, "name" : rName, "rank" : rRank, "thumb" : rThumb, "special" : rSpecial, "modify" : rModify]
                    arrayObject.insert(dictNewsModel, at: i)
                    
                    i = i + 1
                    
                    
                }
                
            }
            
            
        }catch{
            
            
        }
        
        return arrayObject
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //NSLog("You selected cell number: \(indexPath.row)!")
        
        var data  = restaurantListObject[(indexPath as NSIndexPath).row]
        //  NSLog("You selected cell id: \(data["id"]!)")
        Shared.shared.restaurantsName = data["name"]
        Shared.shared.restaurantsId = data["id"]

        
        //self.performSegueWithIdentifier("NewsChild", sender: self)
        
        UserDefaults.standard.set(data["id"]!, forKey: "restaurantId")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurantsChild") as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
        
    }

    
    
    
    
    func setDefault() {
      
        /* default section name */
        sectionName = sectionRestaurantName
        sectionNameFa = sectionRestaurantNamePL

//        
//        self.foodSearchSubjectBtn.backgroundColor = component().setBgColor(100,green: 100, blue: 100)
//        self.foodSearchSubjectBtn.layer.borderWidth = 0
//        self.foodSearchSubjectBtn.setTitleColor(component().setBgColor(255,green: 255, blue: 255), forState: .Normal)
//        
//        self.addressSearchSubject.backgroundColor = component().setBgColor(100,green: 100, blue: 100)
//        self.addressSearchSubject.layer.borderWidth = 0
//        self.addressSearchSubject.setTitleColor(component().setBgColor(255,green: 255, blue: 255), forState: .Normal)
//        
//        self.restaurantSearchSubjectBtn.backgroundColor = UIColor.clearColor()
//        self.restaurantSearchSubjectBtn.layer.borderWidth = 1
//        self.restaurantSearchSubjectBtn.layer.borderColor = self.getBorderColor()
//        self.restaurantSearchSubjectBtn.setTitleColor(component().setBgColor(100,green: 100, blue: 100), forState: .Normal)
        
        
        self.foodSearchSubjectBtn.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.foodSearchSubjectBtn.layer.borderWidth = 0
        self.foodSearchSubjectBtn.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        
        self.addressSearchSubject.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.addressSearchSubject.layer.borderWidth = 0
        self.addressSearchSubject.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        
        self.restaurantSearchSubjectBtn.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.restaurantSearchSubjectBtn.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        
        getClearTable()
      //  getSpecificRestaurant(sectionName, keyword: "رستوران")

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.session.invalidateAndCancel()
    }
    
    
}

