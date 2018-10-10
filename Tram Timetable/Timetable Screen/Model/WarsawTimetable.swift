//
//  WarsawTimetable.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

struct WarsawTimetableResponse: Codable {
    let result: [WarsawTimetable]
}

struct WarsawTimetable: Codable {
    let values: [WarsawTimetableKV]
}

struct WarsawTimetableKV: Codable {
    let value: String
    let key: String
}
