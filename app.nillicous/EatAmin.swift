//
//  EatAmin.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 8/14/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import UIKit


class EatAmin: UIViewController{
    
    
    @IBOutlet weak var labelToken: UILabel!
    @IBAction func telegramMe(_ sender: AnyObject) {
        
        UIApplication.shared.openURL(URL(string: "http://telegram.me/eatamin")!)

        
    }
    
    @IBAction func clickToCall(_ sender: AnyObject) {
        
        let url:URL = URL(string: "tel://+989366040252")!
        UIApplication.shared.openURL(url)
        
    }
    
    
    @IBAction func clicktoTell(_ sender: AnyObject) {
        
        let url:URL = URL(string: "tel://+985133666131")!
        UIApplication.shared.openURL(url)

        
    }
    
    @IBAction func clickToCall2(_ sender: AnyObject) {
        
        
        let url:URL = URL(string: "tel://+989151094588")!
        UIApplication.shared.openURL(url)

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.labelToken?.text = NSUserDefaults.standardUserDefaults().objectForKey("deviceToken") as! String
 //           print(NSUserDefaults.standardUserDefaults().objectForKey("deviceToken") as! String)
        
        
    }
    
    
}

