//
//  MapScreenViewController.swift
//  Tram Timetable
//
//  Created by Mikołaj-iMac on 01.10.2018.
//  Copyright © 2018 Mikołaj Płachta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapScreenViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager!
    
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
        
        mapView.delegate = self
        
        // load timetable from server
        self.viewModel.loadTramStops()
        startReadingLocation()
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
    
    func startReadingLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension MapScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // calculate the closest stop
        viewModel.calculateClosestStop(location: userLocation.coordinate)
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
}

extension MapScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        guard let locationName = annotation.title else { return nil }
        if let stopAnnotation = annotation as? StopPoint {
            if viewModel.closestStop == stopAnnotation.stopId {
                annotationView.pinTintColor = UIColor.blue
            } else {
                annotationView.pinTintColor = UIColor.red
            }
        }
        
        return annotationView
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
            point
            mapView.addAnnotation(point)
        })
    }
}
