//
//  Restaurants.swift
//  app.nillicous
//
//  Created by Ali Ghayeni on 7/20/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class Restaurants: BaseAdapter, UITableViewDelegate{
    
    @IBOutlet weak var internetStatusBar: UIView!
    
    
    var restaurantListObject:[Dictionary <String, String>] = []
    var restaurantListObject1:[Dictionary <String, String>] = []
    var restaurantListObject2:[Dictionary <String, String>] = []
    var restaurantListObject3:[Dictionary <String, String>] = []

    var refreshControl: UIRefreshControl!
    @IBOutlet weak var retaurantTable: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var oneStar  = UIImage(named: "onestar")
    var twoDtar  = UIImage(named: "twostar")
    var threeStar  = UIImage(named: "threestar")

    
    @IBAction func showReserve(_ sender: AnyObject) {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReserveReport") as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
    }
    
    @IBAction func searchBarBtn(_ sender: AnyObject) {
        
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Search") as UIViewController
        self.present(viewController, animated: false, completion: nil)

        
        
    }
    @IBAction func unwindToThisViewController(_ segue: UIStoryboardSegue) {
      //  print("Returned from detail screen")
        UITabBar.appearance().alpha = 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        retaurantTable.alpha = 0
        self.getRestaurant()
        
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(Restaurants.refresh(_:)), for: UIControlEvents.valueChanged)
        retaurantTable.addSubview(refreshControl) // not required when using UITableViewController

        let netView = internetStatusBar
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(Restaurants.refresh(_:)))
        netView?.isUserInteractionEnabled = true
        netView?.addGestureRecognizer(tapGestureRecognizer)

        
    }
    
    func refresh(_ sender:AnyObject) {
        
        if Reachability.isConnectedToNetwork() {
        print("start refreshing!")
            
            loadingIndicator.alpha = 1
            loadingIndicator.startAnimating()
            retaurantTable.alpha = 0
        self.getRestaurant()
          
        }else{
        self.refreshControl.endRefreshing()
        self.internetStatusBar.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurantListObject.count
    }

    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
       
        
      //  let cellIdentifier =  "restaurantCustomRow"
       
        var data  = restaurantListObject[(indexPath as NSIndexPath).row]

        
        var cellIdentifier =  "restaurantCustomRow1"
        
        if "1" == data["reserve"] {
            
            cellIdentifier =  "restaurantCustomRow2"
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! restaurantCustomRow
        
        
        
        
        
        cell.crRestaurantRank.rating = 0
         cell.crRestaurantRank.alpha = 0
        
        //cell.newsTitle?.text = data["title"]
        cell.crRestaurantName?.text = data["name"]
        
        
        cell.crRestaurantThumbnail?.layer.cornerRadius = 15
        cell.crRestaurantThumbnail?.layer.masksToBounds = true

        
        var temp = ""
            temp = data["thumb"]!
        if temp.characters.count > 3 {
        // get data of the image

            
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

    func getRestaurant(){
        
        
        var isDataAvailable = false
        self.internetStatusBar.alpha = 0
        
        let session = URLSession.shared
        let url = URL(string: mainUrl+restaurantUrl)!
        
        let request = NSMutableURLRequest(url: url)
        //request.setValue("clientIDhere", forHTTPHeaderField: "Authorization")
        //request.addValue("clientIDhere", forHTTPHeaderField: "Authorization")
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        
//        let postString = "id=13&name=Jack"
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in

                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                    print("Not a 200 response")
                    
                    
                    self.internetStatusBar.alpha = 1
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.alpha = 0
                    self.refreshControl.endRefreshing()

                    print("after efect!")
                    return
                }
                
                if let _ = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                    //print(ipString)
                    
                     self.restaurantListObject1 = self.parseRestaurantsJsonArray(data!)
                     if self.restaurantListObject1.count > 0 {
                     self.restaurantListObject =  []
                     self.restaurantListObject = self.restaurantListObject1
                     isDataAvailable = true
                  
                    }
                        
                   
                    
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    print("diss patch!")
                    self.refreshControl.endRefreshing()
                    if isDataAvailable {
                        
                        self.loadDataInTable()
                    
                    }else{
                        
                        self.internetStatusBar.alpha = 1
                        self.loadingIndicator.stopAnimating()
                        self.loadingIndicator.alpha = 0
                        self.refreshControl.endRefreshing()
                        
                    }
                    
                    print("end refreshing!")

                    
                }
                //hide indicator after data is loaded
                })
            task.resume()
        })
        
        
        
    }
    
    func loadDataInTable(){
    
        
        print(self.restaurantListObject.count)
        if self.restaurantListObject.count > 0 {
            
        retaurantTable.reloadData()
        retaurantTable.alpha = 1
            
        }
        loadingIndicator.alpha = 0
        loadingIndicator.stopAnimating()


        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       

        
        
        var data  = restaurantListObject[(indexPath as NSIndexPath).row]
        //  NSLog("You selected cell id: \(data["id"]!)")
        
        Shared.shared.restaurantsName = data["name"]
        print(data["name"])
        print(data["thumb"])
        var temp = ""
        temp = data["thumb"]!
        if temp.characters.count > 3 {
        Shared.shared.restaurantsLogoAddress = mainUrl + temp
        }
        Shared.shared.restaurantsId = data["id"]

        UserDefaults.standard.set(data["id"]!, forKey: "restaurantId")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RestaurantsChild") as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
        
    }

  
   

}
