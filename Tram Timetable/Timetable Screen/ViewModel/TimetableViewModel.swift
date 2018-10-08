//
//  TimetableViewModel.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 08.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

class TimetableViewModel: TimetableViewModelBase {
    
    weak var delegate: TimetableViewDelegate?
    
    private let apiServices: TramServicesProtocol = TramServices.instance
}
