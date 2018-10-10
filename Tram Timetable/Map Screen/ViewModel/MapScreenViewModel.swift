//
//  MapScreenViewModel.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 03.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import CoreLocation

class MapScreenViewModel: MapScreenViewModelBase {
    
    weak var delegate: MapScreenViewDelegate?
    
    var stops: [Stops] = []
    var closestStop: String = ""
    var currentLocation: CLLocationCoordinate2D?
    
    private let apiServices: TramServicesProtocol = TramServices.instance
    
    func loadTramStops() {
        apiServices.stopsService() { (result: NetworkResponse<StopsResponse>) in
            switch result {
                case .success(let listOfStops):
                    self.stops.removeAll()
                    self.stops = listOfStops.stops
                    self.delegate?.showPinsOnMap(stops: self.stops.map({ StopPoint(stopId: $0.stopID,locationName: $0.name, latitude: $0.latitude, longitude: $0.longitude) }))
                    self.calculateClosestStop()
                case .failure(_, let error):
                    let dd = 0
//                    self.delegate?.presentErrorMessage(error: error!)
            }
        }
    }
    
    func calculateClosestStop() {
        if let location = currentLocation {
            var point = ("", 0.0) // (index, radius)
            stops.forEach({ element in
                let radius = sqrt(pow(element.latitude - location.latitude, 2) + pow(element.longitude - location.longitude, 2))
                if point.0.isEmpty {
                    point = (element.stopID, radius)
                }
                if radius < point.1 {
                    point = (element.stopID, radius)
                }
            })
            closestStop = point.0
        }
    }
}
