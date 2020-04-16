//
//  sharedData.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 12/16/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation



final class Shared {
    static let shared = Shared() //lazy init, and it only runs once
      
    
    var restaurantsName : String!
    var restaurantsLogoAddress : String!
    var restaurantsId : String!

    
    var reserveResDay : String!
    var reserveResYear : String!
    var reserveResMonth : String!
    var reserveResHour : String!
    var reserveResMinute : String!
    var selectedDateTitle : String!
    
}
