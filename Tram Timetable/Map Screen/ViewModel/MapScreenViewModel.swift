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
    
    func loadTramStops() {
        apiServices.stopsService() { (result: NetworkResponse<TramStopsResponse>) in
            switch result {
                case .success(let listOfStops):
                    let dd = listOfStops.stops
                let ddd = dd.count
                case .failure(_, let error):
                    let dd = 0
//                    self.delegate?.presentErrorMessage(error: error!)
            }
        }
    }
}
