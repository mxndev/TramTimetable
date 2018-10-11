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
    var currentLocation: CLLocationCoordinate2D? { get set }
    
    func loadTramStops()
    func calculateClosestStop()
}

extension MapScreenViewModelBase {
    static var instance: MapScreenViewModelBase {
        guard let resolved = SharedContainer.sharedContainer.resolve(MapScreenViewModelBase.self) else {
            let service = MapScreenViewModel()
            SharedContainer.sharedContainer.register(MapScreenViewModelBase.self) { [service] _ in
                service
            }.inObjectScope(.container)
            return service
        }
        return resolved
    }
}

protocol MapScreenViewDelegate: class {
    func showActivityIndicator(loaded: Bool)
    func showPinsOnMap(stops: [StopPoint])
    func showLoadingError()
    func showNoInternetConnectionError()
}
