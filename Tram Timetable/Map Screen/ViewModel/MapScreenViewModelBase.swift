//
//  MapScreenViewModelBase.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 03.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import Foundation

protocol MapScreenViewModelBase {
    var delegate: MapScreenViewDelegate? { get set }
    
    func loadTramStops()
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
}
