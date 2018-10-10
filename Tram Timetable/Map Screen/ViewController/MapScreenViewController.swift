//
//  MapScreenViewController.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit
import MapKit

class MapScreenViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate var viewModel: MapScreenViewModelBase = MapScreenViewModel.instance
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        
        // load timetable from server
        self.viewModel.loadTramStops()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configureSubviews() {
    }
}

extension MapScreenViewController {
    func centerMapOnLocation(location: CLLocation) {
        let radius: Double = pow(10, 4)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapScreenViewController: MapScreenViewDelegate {
    func showPinsOnMap(stops: [StopPoint]) {
//        loadingView.isHidden = true
        
        for point in mapView.annotations {
            mapView.removeAnnotation(point)
        }
        
        stops.forEach({
            let point = $0
            
            if mapView.annotations.count == 0 {
                // if point is first one
                self.centerMapOnLocation(location: CLLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude))
            }
            
            mapView.addAnnotation(point)
        })
    }
}
