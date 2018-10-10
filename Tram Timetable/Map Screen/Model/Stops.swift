//
//  Stops.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 10.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

struct StopsResponse: Codable {
    let stops: [Stops]
    
    enum CodingKeys: String, CodingKey {
        case stops = "stops"
    }
}

struct Stops: Codable {
    let direction: String
    let latitude: Double
    let longitude: Double
    let line: String
    let name: String
    let stopID: String
    
    enum CodingKeys: String, CodingKey {
        case direction = "direction"
        case latitude = "lat"
        case longitude = "lon"
        case line = "line"
        case name = "name"
        case stopID = "stopId"
    }
}
