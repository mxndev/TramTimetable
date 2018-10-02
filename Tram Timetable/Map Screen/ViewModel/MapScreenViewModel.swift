//
//  MapScreenViewModel.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 03.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

class MapScreenViewModel: MapScreenViewModelBase {
    
    weak var delegate: MapScreenViewDelegate?
    
    private let apiServices: TramServicesProtocol = TramServices.instance
}
