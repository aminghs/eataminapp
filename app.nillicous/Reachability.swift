//
//  Reachability.swift
//  com.eatamin
//
//  Created by Ali Ghayeni on 8/15/16.
//  Copyright © 2016 ghayeni.ir. All rights reserved.
//

import Foundation
import SystemConfiguration

open class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
//        }
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        return (isReachable && !needsConnection)

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
        
    }
    
    
}
