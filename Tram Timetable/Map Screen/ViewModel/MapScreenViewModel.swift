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
    
    var stops: [Stops] = []
    
    private let apiServices: TramServicesProtocol = TramServices.instance
    
    func loadTramStops() {
        apiServices.stopsService() { (result: NetworkResponse<StopsResponse>) in
            switch result {
                case .success(let listOfStops):
                    self.stops.removeAll()
                    self.stops = listOfStops.stops
                    self.delegate?.showPinsOnMap(stops: self.stops.map({ StopPoint(locationName: $0.name, latitude: $0.latitude, longitude: $0.longitude) }))
                case .failure(_, let error):
                    let dd = 0
//                    self.delegate?.presentErrorMessage(error: error!)
            }
        }
    }
}
