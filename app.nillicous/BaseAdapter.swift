//
//  BaseAdapter.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/15/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BaseAdapter: UIViewController {

//func getNews(){
//    
//    //var arrayObject:[Dictionary <String, String>] = []
//    let session = NSURLSession.sharedSession()
//    let url = NSURL(string: mainUrl+newsUrl)!
//    
//    let request = NSMutableURLRequest(URL: url)
//    //request.setValue("clientIDhere", forHTTPHeaderField: "Authorization")
//    //request.addValue("clientIDhere", forHTTPHeaderField: "Authorization")
//    request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
//    request.HTTPMethod = "POST"
//    dispatch_async(dispatch_get_main_queue(), {
//        
//        
//        session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//            
//            
//            guard let realResponse = response as? NSHTTPURLResponse where realResponse.statusCode == 200 else{
//                print("Not a 200 response")
//                
//                
//                return
//            }
//            
//            //                 if let ipString = NSString (data:data!, encoding: NSUTF8StringEncoding){
//            //                 print(ipString)
//            //
//            //                 }
//            
//            var i = 0;
//            do {
//                
//                if let newsString = NSString (data:data!, encoding: NSUTF8StringEncoding){
//                    
//                    self.parseJsonArray(data!)
//                    
//                }
//                
//            }catch{
//                
//                
//            }
//            
//            
//            dispatch_async(dispatch_get_main_queue()) {
//               // print("")
//                
//            }
//            //hide indicator after data is loaded
//            }.resume()
//        
//    })
//    
//    
//    
//}

    
           
//    func parseRestaurantJsonArray(data: NSData){
//        
//        
//        do{
//            
//            let arr = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
//            
//            if let restaurantArray = arr as? [[String: AnyObject]]{
//                
//                
//                
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
//                
//                for rData in restaurantArray {
//                    
//                    
//                    
//                    if let datal1 = rData["id"] as? String {
//                        rId = datal1
//                    }
//                    
//                    if let datal1 = rData["name"] as? String {
//                        rName = datal1
//                    }
//                    
//                    
//                    if let datal1 = rData["description"] as? String {
//                        rDescription = datal1
//                    }
//                    
//                    if let datal1 = rData["address"] as? String {
//                        rAddress = datal1
//                    }
//                    
//                    if let datal1 = rData["rank"] as? String {
//                        rRank = datal1
//                    }
//                    
//                    if let datal1 = rData["image1"] as? String {
//                        rImage1 = datal1
//                    }
//                    
//                    if let datal1 = rData["image2"] as? String {
//                        rImage2 = datal1
//                    }
//                    
//                    if let datal1 = rData["image3"] as? String {
//                        rImage3 = datal1
//                    }
//                    
//                    if let datal1 = rData["special"] as? String {
//                        rSpecial = datal1
//                    }
//                    
//                    if let datal1 = rData["morning"] as? String {
//                        rMorning = datal1
//                    }
//                    
//                    if let datal1 = rData["noon"] as? String {
//                        rNoon = datal1
//                    }
//                    if let datal1 = rData["night"] as? String {
//                        rNight = datal1
//                    }
//                    if let datal1 = rData["modify"] as? String {
//                        rModify = datal1
//                    }
//                    
//                    print(getSpecificRestaurants(rId))
//                    
//                    if let groups = rData["group"] as? [AnyObject] {
//                        
//                    
//                        for group in groups {
//
//                            if let datal2 = group["name"] as? String{
//                               // print(datal2)
//                            }
//                            
//                            if let assets = group["assets"] as? [AnyObject] {
//                             
//                                 for asset in assets {
//                                    
//                                    var fid = ""
//                                    var fname = ""
//                                    var fprice = ""
//                                    var funit = ""
//                                    var fshift = ""
//                                   
//                                    if let datal2 = asset["id"] as? String{
//                                       fid = datal2
//                                    }
//                                    if let datal2 = asset["name"] as? String{
//                                        fname = datal2
//                                    }
//                                    if let datal2 = asset["price"] as? String{
//                                       fprice = datal2
//                                    }
//                                    if let datal2 = asset["unit"] as? String{
//                                       funit = datal2
//                                    }
//                                    if let datal2 = asset["shift"] as? String{
//                                       fshift  = datal2
//                                    }
//                                    
//                                    print(getSpecificFoods(fid ,rId: rId))
//                                 
//                                    
//                                }
//                                
//                                
//                                
//                            }
//                            
//                            
//                        }
//                        
//                        
//                        // print(relation[0])
////                        if let dd = relation[0] as? [AnyObject] {
////                            
//////                            nRelation = String(dd[0] as? Int)
//////                            nRelationName = (dd[1] as? String)!
////                            
////                        }
//                      
//                    }
//
//                    
//                    
////                    if let title = news["title"] as? String{
////                        nTitle = title
////                    }
////                    if let rDescription = news["description"] as? String{
////                        nDescription = rDescription
////                    }
////                    
////                    
////                    if let relation = news["relation"] as? [[AnyObject]] {
////                        
////                        // print(relation[0])
////                        if let dd = relation[0] as? [AnyObject] {
////                            
////                            nRelation = String(dd[0] as? Int)
////                            nRelationName = (dd[1] as? String)!
////                            
////                        }
//                        //    nRelation = relation
//                        //   var tid = relation[0][0] as? Int
//                        //   var tname = relation[0][1] as? String
//                        //   let result = relation as! Dictionary<String, String> as Dictionary
//                        //   print("inside")
//                        //                    for rel in relation {
//                        //                    if  let tid  = rel as? String {
//                        //                        nRelation = String(tid)
//                        //                        print(nRelation)
//                        //                    }
//                        
//                        //                    if  let tname  = rel[1] as? String {
//                        //                        nRelationName = String(tname)
//                        //                    }
//                        //   }
//                        
//                        // nRelationName = tname
////                    }
////                    
////                    if let thumb = news["thumb"] as? String{
////                        nThumb = mainUrlThumb+thumb
////                    }
////                    if let special = news["special"] as? String{
////                        nSpecial = special
////                    }
////                    if let create = news["date"] as? String{
////                        
////                        nCreate = splitTheString(create)
////                        
////                    }
////                    if let time = news["time"] as? String{
////                        
////                        nTime = time
////                        
////                    }
////                    
////                    if let timestamp = news["timestamp"] as? Int{
////                        
////                        nTimeStamp = timestamp
////                        
////                    }
////                    
////                    if let modify = news["modify"] as? String{
////                        nModify = modify
////                    }
////                    
//                    
////                    if !getSpecificNews(nId){
////                        self.insertData(nId,newsTitle: nTitle, newsDescription: nDescription, newsThumb: nThumb, newsSpecial: nSpecial, newsCreate: nCreate, newsModify:  nModify, newsRelation: nRelation, newsTime: nTime, newsTimeStamp: nTimeStamp, newsRelationName: nRelationName)
////                    }
//                    
//                }
//                
//            }
//            
//            
//        }catch{
//            
//            
//        }
//        
//    }

    func parseRestaurantsJsonArray(_ data: Data)-> [Dictionary <String, String>]{
        
        var arrayObject:[Dictionary <String, String>] = []
        var arrayObject1:[Dictionary <String, String>] = []
        var arrayObject2:[Dictionary <String, String>] = []
        
        
        do{
            
            let arr = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if let newsArray = arr as? [[String: AnyObject]]{
                
                
                
                var rId = ""
                var rName = ""
                var rRank = ""
                var rThumb = ""
                var rSpecial = ""
                var rModify = ""
                var rReserve = ""
                
                
                var j = 0
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
                   
                    if let reserve = restaurant["reserveEnable"] as? String{
                        rReserve = reserve
                    }
                    
                    let dictNewsModel: Dictionary = ["id" : rId, "name" : rName, "rank" : rRank, "thumb" : rThumb,
                                                     "special" : rSpecial, "modify" : rModify, "reserve" : rReserve]
                    if rSpecial == "1" {
                        arrayObject2.insert(dictNewsModel, at: j)
                        j = j + 1
                    }else{
                        arrayObject1.insert(dictNewsModel, at: i)
                        i = i + 1
                    }
                    
                    
                    
                    
                }
                
            }
            
            
        }catch{
            
            
        }
        
        
        if arrayObject2.count > 0 {
            
            arrayObject = arrayObject2
        }
        
        var n  = arrayObject2.count
        
        for item in arrayObject1 {
            
            arrayObject.insert(item, at: n)
            n = n + 1
            
            
        }
        
        
        
        
        
        return arrayObject
    }
      
////********************************************
    
    func parseJsonArray(_ data: Data){
    
    
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
                
                
                if !getSpecificNews(nId){
                    self.insertData(nId,newsTitle: nTitle, newsDescription: nDescription, newsThumb: nThumb, newsSpecial: nSpecial, newsCreate: nCreate, newsModify:  nModify, newsRelation: nRelation, newsTime: nTime, newsTimeStamp: nTimeStamp, newsRelationName: nRelationName)
                }else{
                    
                    //updateSpecialFieldInTB(nId, nSpecial: nSpecial, nRelation: nRelation, nRelationName: nRelationName)
                     updateSpecialFieldInTB(nId, nSpecial: nSpecial, nRelation: nRelation, nRelationName: nRelationName, nModify: nModify, nTitle: nTitle, nDescription: nDescription, nThumb: nThumb)
                }
                
            }
            
        }
        
        
    }catch{
        
        
    }
    
}
    
//    func updateSpecialFieldInTB(_ nId: String, nSpecial: String, nRelation: String, nRelationName: String) {
//        //setUpCoreData
//        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
//
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
//        fetchRequest.predicate = NSPredicate(format: "nId = %@", nId)
//        do{
//            if let fetchResults = try contextNews.fetch(fetchRequest) as? [NSManagedObject] {
//            if fetchResults.count != 0{
//                
//                let managedObject = fetchResults[0]
//                managedObject.setValue(nSpecial, forKey: "nSpecial")
//                managedObject.setValue(nRelation, forKey: "nRelation")
//                managedObject.setValue(nRelationName, forKey: "nRelationName")
//                try contextNews.save()
//                }
//            }
//        }catch{
//            
//        }
//    }

    func updateSpecialFieldInTB(_ nId: String, nSpecial: String, nRelation: String, nRelationName: String, nModify: String, nTitle: String, nDescription: String, nThumb: String ) {
        //setUpCoreData
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
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


    func insertData(_ newsId: String, newsTitle: String, newsDescription: String, newsThumb: String, newsSpecial: String, newsCreate: String, newsModify: String, newsRelation: String, newsTime: String, newsTimeStamp: Int, newsRelationName : String){
    
    //setUpCoreData
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let contextNews: NSManagedObjectContext = appDel.managedObjectContext
    
    // insert into db
    let News = NSEntityDescription.insertNewObject(forEntityName: "News", into: contextNews)
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

    func getNewsTb()-> [Dictionary <String, String>]{
    
    var arrayObject:[Dictionary <String, String>] = []
    
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context01: NSManagedObjectContext = appDel.managedObjectContext
    // select from db
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
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
        let requestR = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
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

    func getSpecificNews(_ id: String)-> Bool{
    
    var idIsFounded = false
    
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context01: NSManagedObjectContext = appDel.managedObjectContext
    // select from db
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
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
    
    func getNewsById(_ id: String){
        
        var arrayObject:[Dictionary <String, String>] = []
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context01: NSManagedObjectContext = appDel.managedObjectContext
        // select from db
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")//NSFetchRequest(entityName: "News")
        request.predicate = NSPredicate(format: "nId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context01.fetch(request)
            
            
            do {
                if (results.count > 0) {
                  
                    
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
                         time = component().replaceString(time)
                        // var timestamp = element.valueForKey("nTimeStamp") as! String
                        
                        
                        // print("id from tb \(id)")
                        var dictNewsModel: Dictionary = ["id" : id, "title" : title, "description" : description, "special" : special,
                                                         "thumb" : thumb, "create" : create, "modify" : modify, "relation" :  relation, "time" : time, "relationname": relationName]
                        arrayObject.insert(dictNewsModel, at: 0)
                   
                    }
                    
                    
                    
                } else {
                       print("NotFound")
                }
                
                
                
            } catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
            
            
            
        }catch{
            
        }
        
        
    }
    
    func splitTheString(_ dateString: String) -> String{
     
        // An example string separated by commas.
        let line =  dateString
        
        // Use componentsSeparatedByString to split the string.
        // ... Split on comma chars.
        let parts = line.components(separatedBy: "-")
        

        
        
        var returnString = dateString
        var monthName = ""
        
               // Result has 3 strings.
//        print(parts.count)
//        print(parts)
//        
//        // Loop over string array.
//        for part in parts {
//            print(part)
//        }
        
        switch parts[1] {
        case "01":
            monthName = "فروردین"
            break
        
        case "02":
            monthName = "اردیبهشت"
            break
            
        case "03":
            monthName = "خرداد"
            break
            
        case "04":
            monthName = "تیر"
            break
            
        case "05":
            monthName = "مرداد"
            break
            
        case "06":
            monthName = "شهریور"
            break
            
        case "07":
            monthName = "مهر"
            break
            
        case "08":
            monthName = "آبان"
            break
            
        case "09":
            monthName = "آذر"
            break
            
        case "10":
            monthName = "دی"
            break
            
        case "11":
            monthName = "بهمن"
            break
            
        case "12":
            monthName = "اسفند"
            break
            
        default:
            monthName = parts[1]
        }
        
//        parts[0]
//        print(parts[1])
//        parts[2]
        
        returnString = component().replaceString(parts[2]) + " " + monthName + " " + component().replaceString(parts[0])

        return returnString
        
    }
    
   
    
    
}
