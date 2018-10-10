//
//  TimetableRow.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import RxSwift

struct TimetableRow {
    let hour: String
    let minutes: Variable<[String]>
}
