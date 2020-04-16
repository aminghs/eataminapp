//
//  ReserveReport.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 12/27/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ReserveReport: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TableViewReserve: UITableView!
    
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var newsArray:[Dictionary <String, String>] = []
    var TableViewHasNoChild = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReserveReport")//NSFetchRequest(entityName: "News")
        let sortDescriptorR = NSSortDescriptor(key: "reserveTimeStamp", ascending: false)
        let sortDescriptorsR = [sortDescriptorR]
        fetchRequest.sortDescriptors = sortDescriptorsR
        fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.predicate = NSPredicate(format: "nId = %@", nId)
        do{
            if let fetchResults = try contextNews.fetch(fetchRequest) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    var i = 0
                    print(fetchResults.count)
                    for result in fetchResults {
                        
                        
                        
                        let reserveDate = (result as AnyObject).value(forKey: "reserveDate") as! String
                        print(reserveDate)

                        let reserveGeustCount = (result as AnyObject).value(forKey: "reserveGeustCount") as! String
                        print(reserveGeustCount)

                        let reserveName = (result as AnyObject).value(forKey: "reserveName") as! String
                        print(reserveName)

                        let reserveRestaurantsName = (result as AnyObject).value(forKey: "reserveRestaurantsName") as! String
                        print(reserveRestaurantsName)

                        let reserveTime = (result as AnyObject).value(forKey: "reserveTime") as! String
                        print(reserveTime)
                        
                        let reserveId = (result as AnyObject).value(forKey: "reserveId") as! String
                        print(reserveId)
                        
                        
                        
                        var dictNewsModel: Dictionary = ["reserveId" : reserveId, "reserveTime" : reserveTime, "reserveRestaurantsName" : reserveRestaurantsName, "reserveName" : reserveName,"reserveGeustCount" : reserveGeustCount, "reserveDate" : reserveDate]
                        self.newsArray.insert(dictNewsModel, at: i)
                        i = i + 1

                        
                    }
                    
                    
                    if self.newsArray.count > 0 {
                        TableViewHasNoChild = false
                    }else{
                        TableViewHasNoChild = true
                    }
                    TableViewReserve.reloadData()
                    
                    
                    
                }
            }
        }catch{
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        var tbCount = 0
        
        if !TableViewHasNoChild {
            
            tbCount = newsArray.count
            
        }else{
           
            tbCount = 1
            
        }
        
        
        return tbCount
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        TableViewReserve.reloadData()
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cellIdentifier =  "ReserveCustomRow"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReserveCustomRow
        
        if !TableViewHasNoChild {
        var data  = newsArray[(indexPath as NSIndexPath).row]
        cell.labelReserveDate?.text = "تاریخ رزرو: " + self.changeFormat(data["reserveDate"]!)
        cell.labelReserveTime?.text = "ساعت رزرو: " + self.changeFormat(data["reserveTime"]!)
        cell.labelReserveGuestCount?.text = "تعداد مهمان ها " + self.changeFormat(data["reserveGeustCount"]!)
        cell.labelReserveName?.text = "رزرو شده برای " + data["reserveName"]! + " در رستوران " + data["reserveRestaurantsName"]!
        cell.labelReseveId?.text = "کد رهگیری این رزرو: " + self.changeFormat(data["reserveId"]!)
        
        
        }
        
        
        
        return cell
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


    
    
    
    
}
