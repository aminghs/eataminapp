//
//  ReserveRestaurants.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 12/16/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import UIKit
import CoreData

class ReserveRestaurants: UIViewController, UITextFieldDelegate{
    
    
    var candleStatus = false
    var cakeStatus = false
    var flowerStatus = false
    var baloonStatus = false
    var filmingStatus = false
    var fireworksStatus = false
    var musicStatus = false
    var photographyStatus = false
    var carStatus = false
    var waitressStatus = false
    var decorateStatus = false
    var fullreserveStatus = false

    
    @IBOutlet weak var restaurantsNameBgView: UIView!
    @IBOutlet weak var restaurantsName: UILabel!
  //  @IBOutlet weak var restaurantsNameBgView: UIView!
  //  @IBOutlet weak var restaurantsName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldGeustCount: UITextField!
    @IBOutlet weak var pickADateBtn: UIButton!
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var pickerDataMonth = ["فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی ","بهمن","اسفند"]

    
    
    @IBAction func unwindToThisViewController(_ segue: UIStoryboardSegue) {
       
        if let value = Shared.shared.selectedDateTitle {
            let tempDate = "رزرو: " + value
            pickADateBtn.setTitle(tempDate, for: UIControlState.normal)
        }
        
        
        
    }
    
    @IBAction func pickADate(_ sender: AnyObject) {
        
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickTimeAndDate") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        self.present(viewController, animated: false, completion: nil)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        restaurantsName.backgroundColor = UIColor.white
        let path = UIBezierPath(roundedRect:restaurantsName.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 13.0, height: 13.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = restaurantsName.bounds;
        maskLayer.path = path.cgPath
        restaurantsName.layer.mask = maskLayer;
        self.restaurantsNameBgView.addSubview(restaurantsName)
        
        
        

        
        self.setCorenerRadiuos(iView: self.textFieldName, wRadious: [.topRight, .topLeft])
        self.setCorenerRadiuos(iView: self.textFieldGeustCount, wRadious: [.bottomLeft, .bottomRight])

        
        
    }
    
    func setCorenerRadiuos(iView: UITextField, wRadious: UIRectCorner){

    
        let maskPath = UIBezierPath(roundedRect: iView.bounds,
                                    byRoundingCorners: wRadious,
                                    cornerRadii: CGSize(width: 13.0, height: 13.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        iView.layer.mask = shape
        iView.layer.masksToBounds = true

    
    }
    
    func setImageInRightSideofTextField(iconName: String, uiTextField: UITextField){
        
        uiTextField.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: iconName)
        imageView.image = image
        uiTextField.rightView = imageView
        
    }
    
    @IBAction func barButtonSubmitReserveData(_ sender: AnyObject) {
        
        
        self.submitDataToServer()

        
        
    }
    @IBAction func submitReserveData(_ sender: AnyObject) {
       
        
        self.submitDataToServer()
//        var bId = "-1"
//        var month = "-1"
//        var day = "-1"
//        var year = "-1"
//        var hour = "-1"
//        var minute = "-1"
//        var number = "-1"
//        var name = "-1"
//        var phone = "-1"
//        
//        
//        if let value = Shared.shared.restaurantsId {
//            bId = value
//        }
//        
//        if let value = Shared.shared.reserveResMonth {
//             month = value
//        }
//        
//        if let value = Shared.shared.reserveResDay {
//              day = value
//        }
//        
//        if let value = Shared.shared.reserveResYear {
//              year = value
//        }
//        
//        if  let value = Shared.shared.reserveResHour {
//              hour = value
//        }
//        
//        if let value = Shared.shared.reserveResMinute {
//              minute = value
//        }
//        
//        if let value = textFieldGeustCount.text {
//            
//            if value.characters.count > 2 {
//                self.textFieldGeustCount.text = "0"
//            }else{
//            number = value
//            }
//        }
//        
//        if let value  = textFieldName.text {
//            name = value
//        }
//        
//        if let value = textFieldPhoneNumber.text{
//            phone = value
//        }
//        
//        
//        //self.setReserveDate(bId, firstName: name, lastName: "Ver(1.0.4)", phone: phone, year: year, month: month, day: day, hour: hour, minute: minute, number: number)
        
        
        
    }
    
    func submitDataToServer(){
    
    var bId = "-1"
    var month = "-1"
    var day = "-1"
    var year = "-1"
    var hour = "-1"
    var minute = "-1"
    var number = "-1"
    var name = "-1"
    var phone = "-1"
       
     let message = "انتخاب تاریخ و زمان رزرو"
     var statusValidation = true
    
    
    if let value = Shared.shared.restaurantsId {
        bId = value
        
    }else{
        statusValidation = false
        self.pickADateBtn.setTitle(message, for: UIControlState.normal)
        }
    
    if let value = Shared.shared.reserveResMonth {
       
    month = value
        
    }else{
        statusValidation = false
        self.pickADateBtn.setTitle(message, for: UIControlState.normal)

        }
    
    if let value = Shared.shared.reserveResDay {
       
     
        day = value
        
    }else{
        statusValidation = false
        self.pickADateBtn.setTitle(message, for: UIControlState.normal)

        }
    
    if let value = Shared.shared.reserveResYear {
   
    year = value
        
    }else{
        statusValidation = false
        self.pickADateBtn.setTitle(message, for: UIControlState.normal)

        }
    
    if  let value = Shared.shared.reserveResHour {
     
    hour = value
        
    }else{
        statusValidation = false
        self.pickADateBtn.setTitle(message, for: UIControlState.normal)

        }
    
    if let value = Shared.shared.reserveResMinute {
 
    minute = value
        
    }else{
        statusValidation = false
        self.pickADateBtn.setTitle(message, for: UIControlState.normal)
        }
    
    if let value = textFieldGeustCount.text {
    
    if value.characters.count > 2 {
    self.textFieldGeustCount.text = ""
    self.textFieldGeustCount.placeholder = "تعداد افراد را دوباره وارد کنید"
        
     statusValidation = false
        
    }else{
    number = value
    }
    }
    
    if let value  = textFieldName.text {
    
        if value.characters.count > 2 && value.characters.count < 30 {
            name = value
        }else{
            self.textFieldName.text = ""
            self.textFieldName.placeholder = "لطفا نام و نام خانوادگی صحیح را وارد کنید."
            statusValidation = false
        }
        
    }
    
    if let value = textFieldPhoneNumber.text{
        
        if value.characters.count > 10 && value.characters.count < 15 {
            phone = value
        }else{
            self.textFieldPhoneNumber.text = ""
            self.textFieldPhoneNumber.placeholder = "تعداد ارقام تلفن تماس شما معتبر نمی باشد."
            statusValidation = false

        }
    }
    
        if statusValidation{
            self.setReserveDate(bId, firstName: name, lastName: "Ver(1.1)", phone: phone, year: year, month: month, day: day, hour: hour, minute: minute, number: number)
        }

    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

//       UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

        
        self.setImageInRightSideofTextField(iconName: "name_lastname.png", uiTextField: textFieldName)
        self.setImageInRightSideofTextField(iconName: "phone_pad.png", uiTextField: textFieldPhoneNumber)
        self.setImageInRightSideofTextField(iconName: "count.png", uiTextField: textFieldGeustCount)
        
     
        pickADateBtn.layer.cornerRadius = 15;
        pickADateBtn.layer.masksToBounds = true;
        
        textFieldGeustCount.delegate = self
        textFieldName.delegate = self
        textFieldPhoneNumber.delegate = self
        
        
        
        print("*******************************")
        
        if let value = Shared.shared.restaurantsName {
            print(value)
            restaurantsName.text = "رستوران" + " " + value
        }
        if let value = Shared.shared.restaurantsLogoAddress {
            print(value)
        }
        
        
       
        
        
        
    }
 
    
    
    func setReserveDate(_ id: String, firstName: String, lastName: String, phone: String, year: String, month: String, day: String, hour: String, minute: String, number: String){
        
        /**/
        self.showLoading(status: true)
        /**/
        
        var orderStatus = false
        var orderNumber = 0
        var orderError = ""
        
//        var candleStatus = false
//        var cakeStatus = false
//        var flowerStatus = false
//        var baloonStatus = false
//        var filmingStatus = false
//        var fireeorksStatus = false
//        var musicStatus = false
//        var photographyStatus = false
//        var carStatus = false
//        var waitressStatus = false
//        var decorateStatus = false
//        var fullreserveStatus = false
         var token = "empty"
        do {
                if let value = UserDefaults.standard.string(forKey: "deviceToken") {
                  token = value
                }
        }catch{
            fatalError("this is submit uniqeCode error : \(error)")
        }
        
        let session = URLSession.shared

        let url = URL(string: mainUrl+setReserve)!
        let request = NSMutableURLRequest(url: url)
      
        request.setValue("X-Request", forHTTPHeaderField: "95H3F6l5NRlkmlU8w8xoQGTqyW5wYhDmRitPMXDq++RZcnYcEj7zDxDSyoPqNnWsPXWKifLLviH0CmvjaywdQ==")
        request.httpMethod = "POST"
        //print(id)
        let postString = "id=\(id)&firstname=\(firstName)&lastname=\(lastName)&phone=\(phone)&day=\(day)&month=\(month)&year=\(year)&time=\(hour):\(minute)&number=\(number)&unique=\(token)&hasCake=\(cakeStatus)&hasBalloon=\(baloonStatus)&hasCandle=\(candleStatus)&hasFlower=\(flowerStatus)&hasWaitress=\(waitressStatus)&hasCar=\(carStatus)&hasPhotographer=\(photographyStatus)&hasFilming=\(filmingStatus)&hasMusic=\(musicStatus)&hasFullReserve=\(fullreserveStatus)&hasDecorate=\(decorateStatus)&hasFireplay=\(fireworksStatus)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        DispatchQueue.main.async(execute: {
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else{
                   
                    print("Not a 200 response")
                    self.showLoading(status: false)

                    
                    return
                }
                
                if let ipString = NSString (data:data!, encoding: String.Encoding.utf8.rawValue){
                     print(ipString)
                    
                    /**/
                    do{
                        
                        let arr = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        if let groups = arr as? AnyObject {
                            
                                if let status = groups["status"] as? Bool {
                                    orderStatus = status
                                    if status {
                                        
                                        if let order = groups["order"] as? Int {
                                            orderNumber = order
                                        }
                                    }
                                }
                               if let status = groups["error"] as? String {
                                orderError = status /*time less than 20 minute*/ /*reserve full*/
                               }

                        }
                    
                    }catch{
                        print("this is error \(error)")
                    }
                    /**/
                }
                
                
                
                DispatchQueue.main.async {
            

                    /**/
                    self.showLoading(status: false)
                    if orderStatus {
                        
                        var restaurantsName = ""
                        if let value = Shared.shared.restaurantsName {
                            restaurantsName = value
                        }

                        let tmName = self.pickerDataMonth[Int(month)!-1]
                        
                        self.addToReserveDb(id: String(orderNumber), rDate: "\(day) / \(tmName) / \(year)", rGuestCont: number, rName: firstName, rRestaurantsName: restaurantsName, rTime: "\(hour):\(minute)")
                        
                        self.showReserveStatus(reserveMessage: "رزرو شما با موفقیت انجام شد، کد سفارش شما: \(String(orderNumber)) جهت هماهنگی های بیشتر همکاران ما با شما تماس خواهند گرفت.",reserveStatus: true)
            
                        
                    }else{
                        
                        switch orderError {
                            
                         case "time less than 20 minute":
                            self.showReserveStatus(reserveMessage: "تاریخ و زمان رزرو شما مجاز نمی باشد. لطفا بررسی کنید.", reserveStatus: false)
                            break;
                            
                         case "reserve full":
                            self.showReserveStatus(reserveMessage: "ظرفیت رزرو رستوران برای این روز تکمیل است.", reserveStatus: false)
                            break;
                        default:
                             self.showReserveStatus(reserveMessage: "لطفا دوباره تلاش کنید.", reserveStatus: false)
                            
                        }
                        
                       

                        
                    }
                    /**/
                
                    
                    
                }
                //hide indicator after data is loaded
            })
            task.resume()
            
        })
        
        
        
    }
   
    func showLoading(status: Bool){
        
        if status {
            
           
            let yourAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
            var attrString = NSMutableAttributedString(string: "لطفا کمی صبر کنید.", attributes: yourAttributes)
            attrString.addAttribute(NSFontAttributeName, value: UIFont(name: "IRANSans", size: 12.0)!, range: NSMakeRange(0, attrString.length))
           // self.attributedText = attrString

            
            let alert = UIAlertController(title: nil, message: "لطفا کمی صبر کنید.", preferredStyle: .alert)
            alert.setValue(attrString, forKey: "attributedMessage")
            alert.view.tintColor = UIColor.black
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50,height: 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
        }else{
            
            self.dismiss(animated: false, completion: nil)

            
        }
        
    }
   
    func showReserveStatus(reserveMessage: String, reserveStatus: Bool){
        
        let yourAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        var attrString = NSMutableAttributedString(string: reserveMessage, attributes: yourAttributes)
        attrString.addAttribute(NSFontAttributeName, value: UIFont(name: "IRANSans", size: 15.0)!, range: NSMakeRange(0, attrString.length))
        // self.attributedText = attrString
        let alert = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        alert.setValue(attrString, forKey: "attributedMessage")
        alert.view.tintColor = UIColor.black
//        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50,height: 50)) as UIActivityIndicatorView
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//        alert.view.addSubview(loadingIndicator)
        alert.addAction(UIAlertAction(title: "متوجه شدم", style: .destructive, handler: { action in
                switch action.style{
                case .default:
                print("default")

                case .cancel:
                print("cancel")
            
                case .destructive:
                print("destructive")
                
                    if reserveStatus{
                        self.dismiss(animated: false, completion: nil)
                    }
                }
                }))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func addToReserveDb(id: String, rDate: String, rGuestCont: String, rName: String, rRestaurantsName: String, rTime: String){
        
        let contextNews: NSManagedObjectContext = appDel.managedObjectContext
                let News = NSEntityDescription.insertNewObject(forEntityName: "ReserveReport", into: contextNews)

        
       //NSDate().timeIntervalSince1970// reserveTimeStamp
                News.setValue(String(NSDate().timeIntervalSince1970), forKey: "reserveTimeStamp")
                News.setValue(id, forKey: "reserveId")
                News.setValue(rDate, forKey: "reserveDate")
                News.setValue(rGuestCont, forKey: "reserveGeustCount")
                News.setValue(rName, forKey: "reserveName")
                News.setValue(rRestaurantsName, forKey: "reserveRestaurantsName")
                News.setValue(rTime, forKey: "reserveTime")
        do{
            try contextNews.save()
        }catch{
         fatalError("this is error \(error)")
        }


        
    }
    
    
    
    /**/
   
    
    

    
    @IBOutlet weak var cakeBtn: UIButton!
    @IBOutlet weak var baloonBtn: UIButton!
    @IBOutlet weak var candleBtn: UIButton!
    @IBOutlet weak var flowerBtn: UIButton!
    @IBOutlet weak var filmingBtn: UIButton!
    @IBOutlet weak var fireWorksbtn: UIButton!
    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var photopraphyBtn: UIButton!
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var waitressBtn: UIButton!
    @IBOutlet weak var decoreBtn: UIButton!
    @IBOutlet weak var fullreserveBtn: UIButton!
    
    
    
    @IBAction func hasFullreserve(_ sender: AnyObject) {
        
        if !self.fullreserveStatus {
            let image = UIImage(named: "ic_fullreserve_on") as UIImage!
            self.fullreserveBtn.setImage(image, for: .normal)
            self.fullreserveStatus = true
        }else{
            let image = UIImage(named: "ic_fullreserve_off") as UIImage!
            self.fullreserveBtn.setImage(image, for: .normal)
            self.fullreserveStatus = false
        }
        
        
    }
    
    
    
    
    
    @IBAction func hasFilming(_ sender: AnyObject) {
        
        if !self.filmingStatus {
            let image = UIImage(named: "ic_filming_on") as UIImage!
            self.filmingBtn.setImage(image, for: .normal)
            self.filmingStatus = true
        }else{
            let image = UIImage(named: "ic_filming_off") as UIImage!
            self.filmingBtn.setImage(image, for: .normal)
            self.filmingStatus = false
        }

        
    }
    @IBAction func hasFireWork(_ sender: AnyObject) {
        
        if !self.fireworksStatus {
            let image = UIImage(named: "ic_firework_on") as UIImage!
            self.fireWorksbtn.setImage(image, for: .normal)
            self.fireworksStatus = true
        }else{
            let image = UIImage(named: "ic_firework_off") as UIImage!
            self.fireWorksbtn.setImage(image, for: .normal)
            self.fireworksStatus = false
        }

        
    }
    @IBAction func hasMusic(_ sender: AnyObject) {
        
        if !self.musicStatus {
            let image = UIImage(named: "ic_music_on") as UIImage!
            self.musicBtn.setImage(image, for: .normal)
            self.musicStatus = true
        }else{
            let image = UIImage(named: "ic_music_off") as UIImage!
            self.musicBtn.setImage(image, for: .normal)
            self.musicStatus = false
        }
        
    }
    @IBAction func hasPhotography(_ sender: AnyObject) {
        
        if !self.photographyStatus {
            let image = UIImage(named: "ic_photography_on") as UIImage!
            self.photopraphyBtn.setImage(image, for: .normal)
            self.photographyStatus = true
        }else{
            let image = UIImage(named: "ic_photography_off") as UIImage!
            self.photopraphyBtn.setImage(image, for: .normal)
            self.photographyStatus = false
        }

        
    }
    @IBAction func hasCar(_ sender: AnyObject) {
        
        if !self.carStatus {
            let image = UIImage(named: "ic_car_on") as UIImage!
            self.carBtn.setImage(image, for: .normal)
            self.carStatus = true
        }else{
            let image = UIImage(named: "ic_car_off") as UIImage!
            self.carBtn.setImage(image, for: .normal)
            self.carStatus = false
        }
        
    }
    @IBAction func hasWaitress(_ sender: AnyObject) {
        
        if !self.waitressStatus {
            let image = UIImage(named: "ic_waitress_on") as UIImage!
            self.waitressBtn.setImage(image, for: .normal)
            self.waitressStatus = true
        }else{
            let image = UIImage(named: "ic_waitress_off") as UIImage!
            self.waitressBtn.setImage(image, for: .normal)
            self.waitressStatus = false
        }
        
    }
    @IBAction func hasDecorate(_ sender: AnyObject) {
        
        if !self.decorateStatus {
            let image = UIImage(named: "ic_decorate_on") as UIImage!
            self.decoreBtn.setImage(image, for: .normal)
            self.decorateStatus = true
        }else{
            let image = UIImage(named: "ic_decorate_off") as UIImage!
            self.decoreBtn.setImage(image, for: .normal)
            self.decorateStatus = false
        }

        
    }
    
    
    
    
    
    
    @IBAction func hasFlower(_ sender: AnyObject) {
        
        if !self.flowerStatus {
            let image = UIImage(named: "ic_flower_on") as UIImage!
            self.flowerBtn.setImage(image, for: .normal)
            self.flowerStatus = true
        }else{
            let image = UIImage(named: "ic_flower_off") as UIImage!
            self.flowerBtn.setImage(image, for: .normal)
            self.flowerStatus = false
        }

        
    }
   
    @IBAction func hasCake(_ sender: AnyObject) {
        
        if !self.cakeStatus {
            let image = UIImage(named: "ic_cake_on") as UIImage!
            self.cakeBtn.setImage(image, for: .normal)
            self.cakeStatus = true
        }else{
            let image = UIImage(named: "ic_cake_off") as UIImage!
            self.cakeBtn.setImage(image, for: .normal)
            self.cakeStatus = false
        }
    
    }
    @IBAction func hasBaloon(_ sender: AnyObject) {
    
        
        if !self.baloonStatus {
            let image = UIImage(named: "ic_baloon_on") as UIImage!
            self.baloonBtn.setImage(image, for: .normal)
            self.baloonStatus = true
        }else{
            let image = UIImage(named: "ic_baloon_off") as UIImage!
            self.baloonBtn.setImage(image, for: .normal)
            self.baloonStatus = false
        }
        
    }
    @IBAction func hasCandle(_ sender: AnyObject) {
    
        if !self.candleStatus {
            let image = UIImage(named: "ic_candle_on") as UIImage!
            self.candleBtn.setImage(image, for: .normal)
            self.candleStatus = true
        }else{
            let image = UIImage(named: "ic_candle_off") as UIImage!
            self.candleBtn.setImage(image, for: .normal)
            self.candleStatus = false
        }

    }
    
    
}


