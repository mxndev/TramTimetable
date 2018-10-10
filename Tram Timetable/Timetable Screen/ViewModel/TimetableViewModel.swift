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
        apiServices.timetableService(stopID: "7016", stopNr: "07", line: "35") { (result: NetworkResponse<WarsawTimetableResponse>) in
            switch result {
                case .success(let warsawTimetableResponse):
                    self.convertToTimetableRow(warsawTimetable: warsawTimetableResponse.result)
                case .failure(_, let error):
                    let dd = 0
//                    self.delegate?.presentErrorMessage(error: error!)
            }
            self.delegate?.showActivityIndicator(loaded: true)
        }
    }
    
    func convertToTimetableRow(warsawTimetable: [WarsawTimetable]) {
        timetable.value.removeAll()
        warsawTimetable.forEach({ $0.values.filter({ $0.key == "czas" }).forEach({ addNewRecordToTimetable(hour: String($0.value.split(separator: ":", maxSplits: 2, omittingEmptySubsequences: true)[0]), minutes: String($0.value.split(separator: ":", maxSplits: 2, omittingEmptySubsequences: true)[1])) }) })
    }
    
    func addNewRecordToTimetable(hour: String, minutes: String) {
        if timetable.value.filter({ $0.hour == hour }).count > 0 {
            if let index = timetable.value.index(where: { row -> Bool in row.hour == hour }) {
                timetable.value[index].minutes.value.append(minutes)
            }
        } else {
            timetable.value.append(TimetableRow(hour: hour, minutes: Variable([minutes])))
        }
    }
}
