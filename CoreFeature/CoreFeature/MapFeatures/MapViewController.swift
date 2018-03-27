//
//  MapViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/13/18.
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

    func setupUserTrackingButtonAndScaleView() {
        mapView.showsUserLocation = true
        if #available(iOS 11.0, *) {
            let button = MKUserTrackingButton(mapView: mapView)
            button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)

        } else {
            // Fallback on earlier versions
        }
        
        
//        if #available(iOS 11.0, *) {
//            let scale = MKScaleView(mapView: mapView)
//            scale.legendAlignment = .trailing
//            scale.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(scale)
//
//            NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
//                                         button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//                                         scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
//                                         scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
//        } else {
//            // Fallback on earlier versions
//        }
//
            
//            let scale = MKScaleView(mapView: mapView)
//            scale.legendAlignment = .trailing
//            scale.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(scale)
//
//            NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
//                                         button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//                                         scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
//                                         scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
//        } else {
//            // Fallback on earlier versions
//        }
//
    }
    
    func setupCompassButton() {
        if #available(iOS 11.0, *) {
            let compass = MKCompassButton(mapView: mapView)
            compass.compassVisibility = .visible
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
            mapView.showsCompass = false
        } else {
            // Fallback on earlier versions
        }

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
             ProgressView.shared.showProgressView(self.view)
            locationManager.requestLocation()
        }
    }
    
    //This gets called when location information comes back. You get an array of locations.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: (location)")
//            let span = MKCoordinateSpanMake(0.05, 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            let radius:CLLocationDistance = 10000
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
            mapView.setRegion(region, animated: true)
            
            
            let src2D:CLLocationCoordinate2D = location.coordinate
            let des2D:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.7825453, longitude: -80.2994987)
            
            showRouteOnMap(pickupCoordinate: src2D, destinationCoordinate: des2D)
            ProgressView.shared.hideProgressView()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: (error)")
    }
    
}

extension MapViewController: MKMapViewDelegate {
    // 1 gets called for every annotation you add to the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("mapView called:", annotation.title.debugDescription)
        
//        if annotation is MKUserLocation {
//            let pin = mapView.view(for: annotation) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//            pin.pinTintColor = UIColor.purple
//            return pin
//
//        } else {
//            guard let annotation = annotation as? PlaceMarkerModel else { return nil }
//            // 3 To make markers appear, you create each view as an MKMarkerAnnotationView.
//            let identifier = "marker"
//            var view: MKMarkerAnnotationView
//            // 4
//            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//                as? MKMarkerAnnotationView {
//                dequeuedView.annotation = annotation
//                view = dequeuedView
//            } else {
//                // 5
//                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                view.canShowCallout = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            }
        

        if annotation is MKUserLocation {
            if #available(iOS 11.0, *) {
                let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                pin.image = UIImage(named: "car_top")
                return pin
            } else {
                let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                pin.image = UIImage(named: "car_top")
                return pin
            }
            
           
            
        } else if let homeAnnotation = annotation as? PlaceMarkerModel {
            if #available(iOS 11.0, *) {
                let pin = mapView.view(for: homeAnnotation) ?? MKAnnotationView(annotation: homeAnnotation, reuseIdentifier: nil)
                pin.image = UIImage(named: "home_top")
                pin.canShowCallout = true
                return pin
//                let identifier = "marker"
//                var view: MKMarkerAnnotationView
//                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//                    as? MKMarkerAnnotationView {
//                    dequeuedView.annotation = homeAnnotation
//                    view = dequeuedView
//                    view.image = UIImage(named: "home_top")
//                } else {
//                    view = MKMarkerAnnotationView(annotation: homeAnnotation, reuseIdentifier: identifier)
//                    view.image = UIImage(named: "home_top")
//                    view.canShowCallout = true
//                    view.calloutOffset = CGPoint(x: -5, y: 5)
//                    view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//                }
            } else {
                let pin = mapView.view(for: homeAnnotation) ?? MKAnnotationView(annotation: homeAnnotation, reuseIdentifier: nil)
                pin.image = UIImage(named: "home_top")
                pin.canShowCallout = true
                return pin
            }
        }
        
        return nil
        
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
    
        //Default marker
        
//      let sourceAnnotation = MKPointAnnotation()
        
//        if let location = sourcePlacemark.location {
//            sourceAnnotation.coordinate = location.coordinate
//        }
        
//        let destinationAnnotation = MKPointAnnotation()
//
//        if let location = destinationPlacemark.location {
//            destinationAnnotation.coordinate = location.coordinate
//        }
        
        // Custom marker
        let newMarker = PlaceMarkerModel(title: "My Home",
                                         locationName: "Address:",
                                        discipline: "Home",
                                        coordinate: destinationCoordinate)
        
        self.mapView.showAnnotations([newMarker], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]

            
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
        
    

            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)

        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        
        renderer.lineWidth = 5.0
        
        return renderer
    }

    
    
}



