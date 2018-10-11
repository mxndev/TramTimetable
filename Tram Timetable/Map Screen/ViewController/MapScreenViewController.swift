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
        
        // calculate the closest stop
        viewModel.currentLocation = userLocation.coordinate
        viewModel.calculateClosestStop()
    }
}

extension MapScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.canShowCallout = true
        
        if let stopAnnotation = annotation as? StopPoint {
            if viewModel.closestStop == stopAnnotation.stopId {
                annotationView.pinTintColor = UIColor.blue
            } else {
                annotationView.pinTintColor = UIColor.red
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.performSegue(withIdentifier: "ShowTimetable", sender: nil)
        if let stopAnnotation = view.annotation as? StopPoint {
            var timetableViewModel = TimetableViewModel.instance
            timetableViewModel.stopInfo = viewModel.stops.filter({ $0.stopID == stopAnnotation.stopId}).count > 0 ? viewModel.stops.filter({ $0.stopID == stopAnnotation.stopId})[0] : nil
        }
        
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
