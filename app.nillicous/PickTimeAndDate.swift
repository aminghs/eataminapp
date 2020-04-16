//
//  PickTimeAndDate.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 12/18/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import UIKit



class PickTimeAndDate: UIViewController, UIPickerViewDelegate  {
    
    
    
    
    @IBOutlet weak var showSelectedDate: UILabel!
    @IBOutlet weak var pickerViewYear: UIPickerView!
    @IBOutlet weak var pickerViewMonth: UIPickerView!
    @IBOutlet weak var pickerViewDay: UIPickerView!
   // @IBOutlet weak var pickerViewTime: UIDatePicker!
    @IBOutlet weak var dslkjfsskflsdjf: UIPickerView!
    @IBOutlet weak var mainDatePickerView: UIView!
//    @IBOutlet weak var mainTimePickerView: UIView!
//
//
//    @IBOutlet weak var pickerViewHour: UIPickerView!
//    @IBOutlet weak var pickerViewMinute: UIPickerView!
    @IBOutlet weak var mainTimePickerView: UIView!
    @IBOutlet weak var pickerViewHour: UIPickerView!
    @IBOutlet weak var pickerViewMinute: UIPickerView!
    var pickerDataYear = ["۱۳۹۵", "۱۳۹۶", "۱۳۹۷"]
    
    var pickerDataMonth = ["فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی ","بهمن","اسفند"]

  
    var pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰","۳۱"]

    var pickerMinute = ["۰۰","۳۰"]
    var pickerHour = ["۰۰","۰۱","۰۲","۰۳","۰۴","۰۵","۰۶","۰۷","۰۸","۰۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳"]
    
    var yearJ: Int = 1
    var monthJ: Int = 1
    var dayJ: Int  = 1

    var refYear = 1
    var refMonth = 1
    var refDay = 1
    
    var refHour = 23
    var refMinute = 59
    
    var hourJ = 0
    var minuteJ = 0
    
    
    @IBAction func selectedDate(_ sender: AnyObject) {
        
        
       // self.performSegue(withIdentifier: "unwindToReserveView", sender: self)

        
   //     if self.yearJ >= self.refYear}
    
        if self.yearJ > self.refYear {
    
//            Shared.shared.reserveResDay = String(self.dayJ)
//            Shared.shared.reserveResMonth = String(self.monthJ)
//            Shared.shared.reserveResYear = String(self.yearJ)
//            Shared.shared.reserveResHour = String(self.hourJ)
//            Shared.shared.reserveResMinute = String(self.minuteJ)
//            Shared.shared.selectedDateTitle = "\(pickerDataDay[self.dayJ]) \(pickerDataMonth[self.monthJ]) ماه \(pickerDataYear[self.yearJ]) ساعت \(pickerMinute[self.minuteJ]) : \(pickerHour[self.hourJ])"
//            self.performSegue(withIdentifier: "unwindToReserveView", sender: self)

            self.setAllData()
            
            
        }else if self.yearJ == self.refYear {
           
            if self.monthJ > self.refMonth {

//                Shared.shared.reserveResDay = String(self.dayJ)
//                Shared.shared.reserveResMonth = String(self.monthJ)
//                Shared.shared.reserveResYear = String(self.yearJ)
//                Shared.shared.reserveResHour = String(self.hourJ)
//                Shared.shared.reserveResMinute = String(self.minuteJ)
//                Shared.shared.selectedDateTitle = "\(pickerDataDay[self.dayJ]) \(pickerDataMonth[self.monthJ]) ماه \(pickerDataYear[self.yearJ]) ساعت \(pickerMinute[self.minuteJ]) : \(pickerHour[self.hourJ])"
//                self.performSegue(withIdentifier: "unwindToReserveView", sender: self)

                self.setAllData()

                
            }else if self.monthJ == self.refMonth {
                
                if self.dayJ > self.refDay {
                    
//                    if self.refHour <= self.hourJ {
//                        
//                    }
                    
//                    Shared.shared.reserveResDay = String(self.dayJ)
//                    Shared.shared.reserveResMonth = String(self.monthJ)
//                    Shared.shared.reserveResYear = String(self.yearJ)
//                    Shared.shared.reserveResHour = String(self.hourJ)
//                    Shared.shared.reserveResMinute = String(self.minuteJ)
//                    Shared.shared.selectedDateTitle = "\(pickerDataDay[self.dayJ]) \(pickerDataMonth[self.monthJ]) ماه \(pickerDataYear[self.yearJ]) ساعت \(pickerMinute[self.minuteJ]) : \(pickerHour[self.hourJ])"
//                    self.performSegue(withIdentifier: "unwindToReserveView", sender: self)

                    self.setAllData()
                    

                
                }else if self.dayJ == self.refDay {
                    
                    if self.refHour < self.hourJ {
                    
//                        Shared.shared.reserveResDay = String(self.dayJ)
//                        Shared.shared.reserveResMonth = String(self.monthJ)
//                        Shared.shared.reserveResYear = String(self.yearJ)
//                        Shared.shared.reserveResHour = String(self.hourJ)
//                        Shared.shared.reserveResMinute = String(self.minuteJ)
//                        Shared.shared.selectedDateTitle = "\(pickerDataDay[self.dayJ]) \(pickerDataMonth[self.monthJ]) ماه \(pickerDataYear[self.yearJ]) ساعت \(pickerMinute[self.minuteJ]) : \(pickerHour[self.hourJ])"
//                        self.performSegue(withIdentifier: "unwindToReserveView", sender: self)
                        self.setAllData()

                        
                    }
    
                }
                
            }else{
               
                print("اشتباه")

            }
    
        }else{
            
            print("اشتباه")
            
        }
    
    
    
    
//            && monthJ >= refMonth && dayJ >= refDay {
//            
//            self.performSegue(withIdentifier: "unwindToReserveView", sender: self)
//
//            
//        }else{
//            
//            print("اشتباه")
//            
//        }
    
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        


       
        pickerViewYear.delegate = self
        pickerViewMonth.delegate = self
        pickerViewDay.delegate = self
        
        pickerViewMinute.delegate = self
        pickerViewHour.delegate = self

        
        self.mainDatePickerView.layer.cornerRadius = 15;
        self.mainDatePickerView.layer.masksToBounds = true;

        self.mainTimePickerView.layer.cornerRadius = 15;
        self.mainTimePickerView.layer.masksToBounds = true;

        
        let date = Date()
        let calendar = Calendar.current
        let componentsDate = calendar.dateComponents([.year, .month, .day, .minute, .hour], from: date)

        var year =  componentsDate.year
        var month = componentsDate.month
        var day = componentsDate.day
        var hour = componentsDate.hour
        var minute = componentsDate.minute
        
        self.hourJ = hour!
        self.refHour = hour!
        
        self.refMinute = minute!
        
//        switch minute {
//        case (minute! < 30):
//            jalaliMinute = "0"
//            break
//        case (minute! >= 30):
//            jalaliMinute = "30"
//            break
//        default:
//            print("default.")
//        }

        if minute! >= 30 {
        self.minuteJ = 1
        }else{
        self.minuteJ = 0
        }
        
        let jDate = toJalaali1(gy: year!, gm: month!, gd: day!)
        //print("\(jDate.year) : \(jDate.month) : \(jDate.day)")
        
       
            
             yearJ = Int(jDate.year) - 1395
             refYear = yearJ
             monthJ = Int(jDate.month) - 1
             refMonth = monthJ
             dayJ = Int(jDate.day) - 1
             refDay = dayJ
        
            pickerViewYear.selectRow(yearJ, inComponent: 0, animated: true)
            pickerViewMonth.selectRow(monthJ, inComponent: 0, animated: true)
            pickerViewHour.selectRow(hour!, inComponent: 0, animated: true)
            if minute! >= 30 {
            pickerViewMinute.selectRow(1, inComponent: 0, animated: true)
            }else{
            pickerViewMinute.selectRow(0, inComponent: 0, animated: true)
            }

            if monthJ < 6 {
                
                pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰","۳۱"]
                pickerViewDay.reloadAllComponents()
                
            }else if monthJ >= 6 && monthJ <= 10{
                
                pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰"]
                pickerViewDay.reloadAllComponents()
                
                
            }else if monthJ > 10 {
                pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹"]
                pickerViewDay.reloadAllComponents()
            
            }
            
            pickerViewDay.selectRow(dayJ, inComponent: 0, animated: true)

        if minute! >= 30 {
        self.setSelectedDate(Syear: yearJ, Smonth: monthJ, Sday: dayJ, Shour: hour!, Sminute: 1)
        }else{
        self.setSelectedDate(Syear: yearJ, Smonth: monthJ, Sday: dayJ, Shour: hour!, Sminute: 0)
  
        }
        
        
        
    }
    
    
    
    
    
    func setSelectedDate(Syear: Int, Smonth: Int, Sday: Int, Shour: Int, Sminute: Int){
        
        var tDay = Sday
        if Sday >= 29 {
          if monthJ < 6 {
         // tDay = Sday - 1
          
          }else if monthJ >= 6 && monthJ <= 10{
            
            tDay = Sday - 1

          }else if monthJ > 10 {
            
            tDay = Sday - 2
          }
        
        }
          self.showSelectedDate.text = "تاریخ رزرو  \(pickerDataDay[tDay]) \(pickerDataMonth[Smonth]) \(pickerDataYear[Syear]) ساعت \(pickerMinute[Sminute]) : \(pickerHour[Shour])"
    }
    
       func numberOfComponentsInPickerView(pickerView : UIPickerView!) -> Int{
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == pickerViewYear{
            return pickerDataYear.count
        } else if pickerView == pickerViewMonth{
            return pickerDataMonth.count
        } else if pickerView == pickerViewDay{
            return pickerDataDay.count
        }else if pickerView == pickerViewHour{
            return pickerHour.count
        }else if pickerView == pickerViewMinute{
             return pickerMinute.count
        }
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerViewYear {
            return pickerDataYear[row]
        } else if pickerView == pickerViewMonth{
            return pickerDataMonth[row]
        }else if pickerView == pickerViewDay{
            return pickerDataDay[row]
        }else if pickerView == pickerViewMinute {
            return pickerMinute[row]
        }else if pickerView == pickerViewHour{
            return pickerHour[row]
        }
        return ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        var pickerLabel = view as? UILabel;

    
        if pickerView == pickerViewYear {

            if (pickerLabel == nil)
            {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "IRANSans", size: 15)
                pickerLabel?.textAlignment = NSTextAlignment.center
            }
            pickerLabel?.text = pickerDataYear[row]
            
        } else if pickerView == pickerViewMonth{
           
            if (pickerLabel == nil)
            {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "IRANSans", size: 15)
                pickerLabel?.textAlignment = NSTextAlignment.center
            }
            pickerLabel?.text = pickerDataMonth[row]
            
        }else if pickerView == pickerViewDay{

            if (pickerLabel == nil)
            {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "IRANSans", size: 15)
                pickerLabel?.textAlignment = NSTextAlignment.center
            }
            pickerLabel?.text = pickerDataDay[row]

            
        }else if pickerView == pickerViewHour{
            
            
            if (pickerLabel == nil)
            {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "IRANSans", size: 15)
                pickerLabel?.textAlignment = NSTextAlignment.center
            }
            pickerLabel?.text = pickerHour[row]

            
        }else if pickerView == pickerViewMinute{
            
            
            if (pickerLabel == nil)
            {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "IRANSans", size: 15)
                pickerLabel?.textAlignment = NSTextAlignment.center
            }
            pickerLabel?.text = pickerMinute[row]

        }
//
//        
        return pickerLabel!;
       }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        
        if pickerView == pickerViewYear {

            print(pickerDataYear[row])
            self.yearJ = row
            
        } else if pickerView == pickerViewMonth{
            
            if row < 6 {
              
                pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰","۳۱"]
                pickerViewDay.reloadAllComponents()
                
            }else if row >= 6 && row <= 10{
                
                pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰"]
                pickerViewDay.reloadAllComponents()

                
            }else if row > 10 {
                pickerDataDay = ["۱","۲","۳","۴","۵","۶","۷","۸","۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹"]
                pickerViewDay.reloadAllComponents()
                
            }
          self.monthJ = row
            //print(pickerDataMonth[row])
        }else if pickerView == pickerViewDay{

           // print(pickerDataDay[row])
          self.dayJ = row
       
        }else if pickerView == pickerViewHour{
            
          self.hourJ = row
        
        }else if pickerView == pickerViewMinute {
            
          self.minuteJ = row
        }
//
      //  self.setSelectedDate(Syear: yearJ, Smonth: monthJ, Sday: pickerDataDay)

        self.setSelectedDate(Syear: self.yearJ, Smonth: self.monthJ, Sday: self.dayJ, Shour: self.hourJ, Sminute: self.minuteJ)

    }
    
    func setAllData(){
        
        
        Shared.shared.reserveResDay = String(self.dayJ+1)
        Shared.shared.reserveResMonth = String(self.monthJ+1)
        var jalaliYear = "0"
        switch self.yearJ {
        case 0:
            jalaliYear = "1395"
            break
        case 1:
            jalaliYear = "1396"
            break
        case 2:
            jalaliYear = "1397"
            break
        default:
            jalaliYear = "0"
        }
        Shared.shared.reserveResYear = jalaliYear
        Shared.shared.reserveResHour = String(self.hourJ)
        var jalaliMinute = "0"
        switch self.minuteJ {
        case 0:
            jalaliMinute = "0"
            break
        case 1:
            jalaliMinute = "30"
            break
                default:
                print("default.")
        }
        
        Shared.shared.reserveResMinute = jalaliMinute
        Shared.shared.selectedDateTitle = "\(pickerDataDay[self.dayJ]) \(pickerDataMonth[self.monthJ]) ماه \(pickerDataYear[self.yearJ]) ساعت \(pickerMinute[self.minuteJ]) : \(pickerHour[self.hourJ])"
        self.performSegue(withIdentifier: "unwindToReserveView", sender: self)

        
        
    }
}
