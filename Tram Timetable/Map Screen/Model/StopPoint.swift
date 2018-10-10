//
//  StopPoint.swift
//  Tram Timetable
//
//  Created by Mikołaj Płachta on 10.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import MapKit

class StopPoint: MKPointAnnotation {
    var stopId: String
    init(stopId:String, locationName: String, latitude: Double, longitude: Double) {
        self.stopId = stopId
        super.init()
        
        self.title = locationName
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
