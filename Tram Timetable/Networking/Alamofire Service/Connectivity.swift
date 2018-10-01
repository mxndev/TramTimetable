//
//  Connectivity.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireConnectivity {
    class var isConnected:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
