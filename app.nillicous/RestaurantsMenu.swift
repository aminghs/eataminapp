//
//  Menu.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/30/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RestaurantsMenu: UIViewController, UITableViewDelegate {
    
    
    
    @IBOutlet weak var menuTable: UITableView!
    var menuListObject:[Dictionary <String, String>] = []
    var RestaurantId = ""
   
    @IBOutlet weak var showMorning: UIButton!
    @IBAction func showMorningBtn(_ sender: AnyObject) {
        
        menuListObject.removeAll()
        menuListObject = self.getFoodsTb("morning", rId: RestaurantId)
        menuTable.reloadData()
        
        self.showNight.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showNight.layer.borderWidth = 0
        self.showNight.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        self.showNoon.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showNoon.layer.borderWidth = 0
        self.showNoon.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
      
        self.showMorning.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.showMorning.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        
       
        let maskPath = UIBezierPath(roundedRect: self.showMorning.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.showMorning.layer.mask = shape
        self.showMorning.layer.masksToBounds = true

        
        
        let maskPathNoon = UIBezierPath(roundedRect: self.showNight.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shapeNight = CAShapeLayer()
        shapeNight.path = maskPathNoon.cgPath
        self.showNight.layer.mask = shapeNight
        self.showNight.layer.masksToBounds = true
        
        
        
    }
    
    
    @IBOutlet weak var showNoon: UIButton!
    @IBAction func showNoonBtn(_ sender: AnyObject) {
        
        menuListObject.removeAll()
        menuListObject = self.getFoodsTb("noon", rId: RestaurantId)
        menuTable.reloadData()
     

        self.showNight.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showNight.layer.borderWidth = 0
        self.showNight.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())

        self.showMorning.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showMorning.layer.borderWidth = 0
        self.showMorning.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        self.showNoon.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.showNoon.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        
        
        let maskPath = UIBezierPath(roundedRect: self.showMorning.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.showMorning.layer.mask = shape
        
        
        let maskPathNoon = UIBezierPath(roundedRect: self.showNight.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shapeNight = CAShapeLayer()
        shapeNight.path = maskPathNoon.cgPath
        self.showNight.layer.mask = shapeNight
        
        
    }
    
    @IBOutlet weak var showNight: UIButton!
    @IBAction func showNightBtn(_ sender: AnyObject) {
        
        menuListObject.removeAll()
        menuListObject = self.getFoodsTb("night", rId: RestaurantId)
        menuTable.reloadData()
        
        
     
        self.showNoon.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showNoon.layer.borderWidth = 0
        self.showNoon.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())


        self.showMorning.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showMorning.layer.borderWidth = 0
        self.showMorning.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())


        self.showNight.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.showNight.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        
        
        let maskPath = UIBezierPath(roundedRect: self.showMorning.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.showMorning.layer.mask = shape
        
        
        let maskPathNoon = UIBezierPath(roundedRect: self.showNight.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shapeNight = CAShapeLayer()
        shapeNight.path = maskPathNoon.cgPath
        self.showNight.layer.mask = shapeNight
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let restaurantId = UserDefaults.standard.object(forKey: "restaurantId") as! String
        RestaurantId = restaurantId
        
        menuListObject = self.getFoodsTb("noon", rId: RestaurantId)
        
        
        self.showNight.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showNight.layer.borderWidth = 0
        self.showNight.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        self.showMorning.backgroundColor = component().setBgColor(216,green: 218, blue: 217)
        self.showMorning.layer.borderWidth = 0
        self.showMorning.setTitleColor(component().setBgColor(34,green: 192, blue: 100), for: UIControlState())
        
        self.showNoon.backgroundColor = component().setBgColor(34,green: 192, blue: 100)
        self.showNoon.setTitleColor(component().setBgColor(255,green: 255, blue: 255), for: UIControlState())
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        menuTable.reloadData()

        
        let maskPath = UIBezierPath(roundedRect: self.showMorning.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.showMorning.layer.mask = shape
        
        
        
        let maskPathNoon = UIBezierPath(roundedRect: self.showNight.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shapeNight = CAShapeLayer()
        shapeNight.path = maskPathNoon.cgPath
        self.showNight.layer.mask = shapeNight

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return menuListObject.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
        {
            
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight = 100.0;//(Maximum Height that should be assigned to your cell)
            let cellIdentifier =  "restaurantsMenuCustomRow"
             
       
        var data  = menuListObject[(indexPath as NSIndexPath).row]

           


            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! restaurantsMenuCustomRow
            cell.foodName?.text  =  data["name"]
            cell.foodPrice?.text = self.changeFormat(data["price"]!) + " " + "تومان"
            cell.foodDescription?.text = data["description"]
            cell.cellHeight?.constant = component().heightForView(data["name"]!,label: cell.foodName)
            return cell
            
         
    }
    
    
    func getFoodsTb(_ shift: String, rId: String)-> [Dictionary <String, String>]{
        
    var arrayObject:[Dictionary <String, String>] = []
    
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context01: NSManagedObjectContext = appDel.managedObjectContext
    // select from db
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Foods")//NSFetchRequest(entityName: "Foods")
    request.predicate = NSPredicate(format: "rId == %@", rId)
    request.predicate = NSPredicate(format: "fShift == %@", shift)
        //    let sortDescriptor = NSSortDescriptor(key: "nTimeStamp", ascending: false)
    //    let sortDescriptors = [sortDescriptor]
    //    request.sortDescriptors = sortDescriptors
    request.returnsObjectsAsFaults = false
    
    do{
    let results = try context01.fetch(request)
    
    
    //        do {
    if (results.count > 0) {
    var i = 0
    for element in results {
    
    var id = (element as AnyObject).value(forKey: "fId") as! String
    var name = (element as AnyObject).value(forKey: "fName") as! String
    var price = (element as AnyObject).value(forKey: "fPrice") as! String
    var shift = (element as AnyObject).value(forKey: "fShift") as! String
    var unit = (element as AnyObject).value(forKey: "fUnit") as! String
    var rId = (element as AnyObject).value(forKey: "rId") as! String
    var description = (element as AnyObject).value(forKey: "fDescription") as! String

    var dictNewsModel: Dictionary = ["id" : id, "name" : name, "price" : price, "shift" : shift,
                                     "unit" : unit, "rid" : rId, "description" : description]
    arrayObject.insert(dictNewsModel, at: i)
    i = i + 1
  
    
        }
    } else {
    print("No data")
    }
    
    }catch{
    
    }
    
    
//    // select from db
//    let requestR = NSFetchRequest(entityName: "News")
//    requestR.predicate = NSPredicate(format: "nSpecial == %@", "1")
//    let sortDescriptorR = NSSortDescriptor(key: "nTimeStamp", ascending: false)
//    let sortDescriptorsR = [sortDescriptorR]
//    requestR.sortDescriptors = sortDescriptorsR
//    requestR.returnsObjectsAsFaults = false
//    
//    do{
//    let results = try context01.executeFetchRequest(requestR)
//    
//    
//    //        do {
//    if (results.count > 0) {
//    var i = 0
//    for element in results {
//    
//    
//    var id = element.valueForKey("nId") as! String
//    var title = element.valueForKey("nTitle") as! String
//    var description = element.valueForKey("nDescription") as! String
//    var special = element.valueForKey("nSpecial") as! String
//    var thumb = element.valueForKey("nThumb") as! String
//    var create = element.valueForKey("nCreate") as! String
//    var modify = element.valueForKey("nModify") as! String
//    var relation = element.valueForKey("nRelation") as! String
//    var relationName = element.valueForKey("nRelationName") as! String
//    
//    var time = element.valueForKey("nTime") as! String
//    // var timestamp = element.valueForKey("nTimeStamp") as! String
//    
//    
//    // print("id from tb \(id)")
//    var dictNewsModel: Dictionary = ["id" : id, "title" : title, "description" : description, "special" : special,
//    "thumb" : thumb, "create" : create, "modify" : modify, "relation" :  relation, "time" : time, "nRelationName": relationName]
//    arrayObject.insert(dictNewsModel, atIndex: i)
//    i = i + 1
//    }
//    } else {
//    print("No data")
//    }
//    
//    }catch{
//    
//    }
//    
    
    
    
    return arrayObject
    
    }

    
    func getBorderColor() -> CGColor {
        
        return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1).cgColor
    }
    
    func getGreenBorderColor() -> CGColor {
        
        return UIColor(red: 34/255, green: 192/255, blue: 100/255, alpha: 1).cgColor
    }
    
    
    
    func changeFormat(_ keyword: String) -> String {
        
        let toArray = keyword.components(separatedBy: "0")
        let backToString = toArray.joined(separator: "۰")
        
        let toArray1 = backToString.components(separatedBy: "1")
        let backToString1 = toArray1.joined(separator: "۱")
        
        let toArray2 = backToString1.components(separatedBy: "2")
        let backToString2 = toArray2.joined(separator: "۲")

        let toArray3 = backToString2.components(separatedBy: "3")
        let backToString3 = toArray3.joined(separator: "۳")

        let toArray4 = backToString3.components(separatedBy: "4")
        let backToString4 = toArray4.joined(separator: "۴")

        let toArray5 = backToString4.components(separatedBy: "5")
        let backToString5 = toArray5.joined(separator: "۵")

        let toArray6 = backToString5.components(separatedBy: "6")
        let backToString6 = toArray6.joined(separator: "۶")

        let toArray7 = backToString6.components(separatedBy: "7")
        let backToString7 = toArray7.joined(separator: "۷")

        let toArray8 = backToString7.components(separatedBy: "8")
        let backToString8 = toArray8.joined(separator: "۸")

        let toArray9 = backToString8.components(separatedBy: "9")
        let backToString9 = toArray9.joined(separator: "۹")

        
        
        return backToString9
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        
        
    return UITableViewAutomaticDimension
    }

}


