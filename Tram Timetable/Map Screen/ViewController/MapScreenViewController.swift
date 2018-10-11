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
    @IBOutlet private weak var loadingView: UIView!
    
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
        mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        // load timetable from server
        self.viewModel.loadTramStops()
        startReadingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.centerMapOnLocation(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
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
            let stopInfo = viewModel.stops.filter({ $0.stopID == stopAnnotation.stopId})
            timetableViewModel.stopInfo.value = stopInfo.count > 0 ? stopInfo[0] : nil
        }
        
    }
}

extension MapScreenViewController: MapScreenViewDelegate {
    func showActivityIndicator(loaded: Bool) {
        loadingView.isHidden = loaded
    }
    
    func showPinsOnMap(stops: [StopPoint]) {
        loadingView.isHidden = true
        
        for point in mapView.annotations {
            mapView.removeAnnotation(point)
        }
        
        stops.forEach({
            mapView.addAnnotation($0)
        })
    }
    
    func showLoadingError() {
        let alertController = UIAlertController(title: "Sorry, error during loading!", message: "Try again later.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topMostController().present(alertController, animated: true)
    }
    
    func showNoInternetConnectionError() {
        let alertController = UIAlertController(title: "Sorry, no internet connection!", message: "Try again later.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topMostController().present(alertController, animated: true)
    }
}
