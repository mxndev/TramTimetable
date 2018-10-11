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
    
    let disposeBag = DisposeBag()
    
    var timetable: Variable<[TimetableRow]> = Variable([])
    var stopInfo: Variable<Stops?> = Variable(nil)
    
    private let apiServices: TramServicesProtocol = TramServices.instance
    
    init() {
        stopInfo.value = nil
        
        stopInfo.asObservable()
            .subscribe(onNext: { _ in
                // load timetable from server
                self.loadTimetable()
            })
            .disposed(by: disposeBag)
    }
    
    func loadTimetable() {
        timetable.value.removeAll()
        self.delegate?.setStopInfo(stopName: "-", direction: "-", lineNumber: "-")
        if let stop = stopInfo.value {
            self.delegate?.showActivityIndicator(loaded: false)
            apiServices.timetableService(stopID: String(stop.stopID[String.Index.init(encodedOffset: 0)..<String.Index.init(encodedOffset: 4)]), stopNr: String(stop.stopID[String.Index.init(encodedOffset: 4)..<String.Index.init(encodedOffset: 6)]), line: stop.line) { (result: NetworkResponse<WarsawTimetableResponse>) in
                switch result {
                    case .success(let warsawTimetableResponse):
                        self.convertToTimetableRow(warsawTimetable: warsawTimetableResponse.result)
                        self.delegate?.setStopInfo(stopName: stop.name, direction: stop.direction, lineNumber: stop.line)
                    case .failure(let error):
                        switch error {
                            case .NoInternetConnection:
                                self.delegate?.showNoInternetConnectionError()
                            default:
                                self.delegate?.showLoadingError()
                        }
                }
                self.delegate?.showActivityIndicator(loaded: true)
            }
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
    
    func calculateNextTramTime(currentTime: Date) -> (Int, Int) {
        // retrieve current time
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pl_PL")
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: currentTime)
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        for (rowIndex, row) in timetable.value.enumerated() {
            for (minuteIndex, minute) in row.minutes.value.enumerated() {
                if let date = formatter.date(from: String(format: "%@ %@:%@", currentDate, row.hour, minute)) {
                    if date > currentTime {
                        return (rowIndex, minuteIndex)
                    }
                }
            }
        }
        return (0, 0)
    }
}
