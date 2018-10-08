//
//  WarsawTimetable.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

struct WarsawTimetableResponse: Codable {
    let ticketTypesArray: [WarsawTimetable]
    
    enum CodingKeys: String, CodingKey {
        case ticketTypesArray = "support_ticket_types"
    }
}

struct WarsawTimetable: Codable {
    let id: Int
    let name: String
    let type: String
}
