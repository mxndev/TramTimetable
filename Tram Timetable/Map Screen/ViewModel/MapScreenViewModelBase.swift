//
//  MapScreenViewModelBase.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 03.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation
import CoreLocation

protocol MapScreenViewModelBase {
    var delegate: MapScreenViewDelegate? { get set }
    
    var stops: [Stops] { get set }
    var closestStop: String { get set }
    
    func loadTramStops()
    func calculateClosestStop(location: CLLocationCoordinate2D)
}

extension MapScreenViewModelBase {
    static var instance: MapScreenViewModelBase {
        guard let resolved = SharedContainer.sharedContainer.resolve(MapScreenViewModelBase.self) else {
            let service = MapScreenViewModel()
            SharedContainer.sharedContainer.register(MapScreenViewModelBase.self) { [service] _ in
                service
            }
            return service
        }
        return resolved
    }
}

protocol MapScreenViewDelegate: class {
    func showPinsOnMap(stops: [StopPoint])
}
