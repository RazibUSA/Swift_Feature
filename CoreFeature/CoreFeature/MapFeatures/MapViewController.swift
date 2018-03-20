//
//  MapViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/13/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView?.showsUserLocation = true
        mapView.delegate = self as? MKMapViewDelegate
       // mapView.mapType = .hybrid
      //mapView.setUserTrackingMode(.follow, animated: true)
        mapView.showsCompass = true
        initLocationParam()
        setupCompassButton()
        setupUserTrackingButtonAndScaleView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUserTrackingButtonAndScaleView() {
        mapView.showsUserLocation = true
        
        let button = MKUserTrackingButton(mapView: mapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let scale = MKScaleView(mapView: mapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scale)
        
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
    
    func setupCompassButton() {
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .visible
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
        mapView.showsCompass = false
    }

    func initLocationParam(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    //This method gets called when the user responds to the permission dialog. If the user chose Allow, the status becomes CLAuthorizationStatus.AuthorizedWhenInUse.
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    //This gets called when location information comes back. You get an array of locations, but you’re only interested in the first item. You don’t do anything with it yet, but eventually you will zoom to this location.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: (location)")
//            let span = MKCoordinateSpanMake(0.05, 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            let radius:CLLocationDistance = 1000
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
            
            mapView.setRegion(region, animated: true)
            
            let newMarker = PlaceMarkerModel(title: "Time Squar",
                                  locationName: "Time Squar",
                                  discipline: "Sculpture",
                                  coordinate: CLLocationCoordinate2D(latitude: 40.758899, longitude: -73.987325))
            mapView.addAnnotation(newMarker)
            
         
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: (error)")
    }
    
}

extension ViewController: MKMapViewDelegate {
    // 1 gets called for every annotation you add to the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("mapView called:", annotation.title.debugDescription)
        
        if annotation is MKUserLocation {
            let pin = mapView.view(for: annotation) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.pinTintColor = UIColor.purple
            return pin
            
        } else {
            guard let annotation = annotation as? PlaceMarkerModel else { return nil }
            // 3 To make markers appear, you create each view as an MKMarkerAnnotationView.
            let identifier = "marker"
            var view: MKMarkerAnnotationView
            // 4
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 5
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            
            
            
            return view

        }
      
        
        
//        let identifier = "User"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//        if annotationView == nil{
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView?.canShowCallout = true
//        } else {
//            annotationView?.annotation = annotation
//        }
//        annotationView?.image = UIImage(named: "car_top")
//        return annotationView
        // 2
    }
}


