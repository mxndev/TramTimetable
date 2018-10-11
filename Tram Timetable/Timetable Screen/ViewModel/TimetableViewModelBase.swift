//
//  TimetableViewModelBase.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import RxSwift

protocol TimetableViewModelBase {
    var delegate: TimetableViewDelegate? { get set }
    
    var timetable: Variable<[TimetableRow]> { get set }
    var stopInfo: Variable<Stops?> { get set }
    
    func loadTimetable()
    func convertToTimetableRow(warsawTimetable: [WarsawTimetable])
    func addNewRecordToTimetable(hour: String, minutes: String)
    func calculateNextTramTime(currentTime: Date) -> (Int, Int)
}

extension TimetableViewModelBase {
    static var instance: TimetableViewModelBase {
        guard let resolved = SharedContainer.sharedContainer.resolve(TimetableViewModelBase.self) else {
            let service = TimetableViewModel()
            SharedContainer.sharedContainer.register(TimetableViewModelBase.self) { [service] _ in
                service
            }.inObjectScope(.container)
            return service
        }
        return resolved
    }
}

protocol TimetableViewDelegate: class {
    func showActivityIndicator(loaded: Bool)
    func setStopInfo(stopName: String, direction: String, lineNumber: String)
    func showLoadingError()
    func showNoInternetConnectionError()
}
