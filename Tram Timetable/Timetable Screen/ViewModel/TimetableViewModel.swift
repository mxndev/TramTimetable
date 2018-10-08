//
//  TimetableViewModel.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import RxSwift

class TimetableViewModel: TimetableViewModelBase {
    weak var delegate: TimetableViewDelegate?
    
    var timetable: Variable<[TimetableRow]> = Variable([])
    
    private let apiServices: TramServicesProtocol = TramServices.instance
    
    func loadTimetable() {
        // TODO: script to download data from server
        timetable.value.append(TimetableRow(hour: "3", minutes: ["32", "23", "33"]))
        timetable.value.append(TimetableRow(hour: "6", minutes: ["01", "15"]))
        timetable.value.append(TimetableRow(hour: "7", minutes: ["32", "23", "33", "45", "33"]))
        timetable.value.append(TimetableRow(hour: "8", minutes: ["32", "44", "33", "33", "45", "33", "58", "33"]))
        timetable.value.append(TimetableRow(hour: "13", minutes: ["32", "18", "33", "14", "33", "33", "45", "33", "58", "33"]))
        timetable.value.append(TimetableRow(hour: "22", minutes: ["32", "23", "18", "33", "33"]))
    }
}
