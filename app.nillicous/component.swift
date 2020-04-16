//
//  component.swift
//  rahpoyanTradingApp
//
//  Created by Ali Ghayeni on 5/21/16.
//  Copyright © 2016 green web. All rights reserved.
//

import Foundation
import UIKit


class component: UIViewController{
    
    
    func heightForView(_ text:String, label:UILabel) -> CGFloat{
        
        var width: CGFloat = label.frame.size.width
        width = ((UIScreen.main.bounds.width)/320)*width
        
        let font = UIFont(name: "IRANSans", size: 16)
        
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    
    func appgetFont(){
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
    }
    
    func setBgColor(_ red:CGFloat, green:CGFloat, blue:CGFloat) ->UIColor {
        
        return UIColor(red: red/256, green: green/256, blue: blue/256, alpha: 1)
    }
    
    func getSizeOFScreen(_ frame: UIView)->CGFloat{
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        // print(String(screenWidth))
        let screenHeight = screenSize.height
        // print(String(screenHeight))
        
        return screenWidth
    }
    
    func isIphone()->Bool{
        var status = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            // It's an iPhone
            // print("iphone")
            status = true
            break;
            
        case .pad:
            //  print("ipad")
            status = false
            
            break;
            // It's an iPad
            
        default:
            status = true
        }
        
        return status
    }
    
    
    func setNavigationBarColorAndFont(){
        
        
        //top bar font color
        let color = component().setBgColor(255,green: 255, blue:255)
        //let color = component().setBgColor(16,green: 66, blue:122)
        if let font = UIFont(name: "IRANSans", size: 13) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName : color]
        }
        //top bar background color
        UINavigationBar.appearance().barTintColor = UIColor(red: 34.0/255.0, green: 192.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        //UINavigationBar.appearance().barTintColor = UIColor(red: 100.0/255.0, green: 117.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    }
    
    
    func replaceString(_ stringNumber: String)->String{
        
        var token = stringNumber
       token =  token.replacingOccurrences(of: "0", with:"۰")
       token =  token.replacingOccurrences(of: "1", with:"۱")
       token =  token.replacingOccurrences(of: "2", with:"۲")
       token =  token.replacingOccurrences(of: "3", with:"۳")
       token =  token.replacingOccurrences(of: "4", with:"۴")
       token =  token.replacingOccurrences(of: "5", with:"۵")
       token =  token.replacingOccurrences(of: "6", with:"۶")
       token =  token.replacingOccurrences(of: "7", with:"۷")
       token =  token.replacingOccurrences(of: "8", with:"۸")
       token =  token.replacingOccurrences(of: "9", with:"۹")
        
        //print(token)
        
        return token
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

    
    //    if NSUserDefaults.standardUserDefaults().objectForKey("toDoList") != nil{
    //
    //    toDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoList") as![String]
    //
    //    }
    
    //    // if user tap out side the keyboard
    //    // the key board goes down
    //    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //
    //
    //        self.view.endEditing(true)
    //
    //    }
    //
    //    // this line of code is for when user push the return button
    //    // it close the key board
    //
    //    func textFieldShouldReturn(TextField: UITextField!) -> Bool {
    //
    //        item.resignFirstResponder()
    //        return true
    //
    //    }
    
    
    //    let tapper = UITapGestureRecognizer(target: self, action:Selector("endEditing"))
    //    tapper.cancelsTouchesInView = false
    //    self.view.addGestureRecognizer(tapper);
    //    func endEditing(){
    //    }
    

    
    /****** this is like Toast *****/
//    let alert = UIAlertController(title: "پیام", message: "متن آزمایشی پیغام.", preferredStyle: UIAlertControllerStyle.alert)
//    
//    //        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//    
//    
//    
//    self.present(alert, animated: true, completion: nil)
//    
//    alert.addAction(UIAlertAction(title: "متوجه شدم", style: .default, handler: { action in
//    switch action.style{
//    case .default:
//    print("default")
//    
//    case .cancel:
//    print("cancel")
//    
//    case .destructive:
//    print("destructive")
//    }
//    }))

   
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

