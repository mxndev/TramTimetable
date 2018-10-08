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
    
    func loadTimetable()
}

extension TimetableViewModelBase {
    static var instance: TimetableViewModelBase {
        guard let resolved = SharedContainer.sharedContainer.resolve(TimetableViewModelBase.self) else {
            let service = TimetableViewModel()
            SharedContainer.sharedContainer.register(TimetableViewModelBase.self) { [service] _ in
                service
            }
            return service
        }
        return resolved
    }
}

protocol TimetableViewDelegate: class {
}
