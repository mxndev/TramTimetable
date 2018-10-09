//
//  Constants.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 10.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

struct Constants {
    struct Networking {
        struct RawDataAPI {
            static let host: String = "https://pastebin.com"
            static let version: String = "raw"
        }
        
        struct WarsawAPI {
            static let host: String = "https://api.um.warszawa.pl"
            static let version: String = "api/action"
            static let key: String = ""
        }
    }
}
