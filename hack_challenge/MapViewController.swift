//
//  MapViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/23/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

let olinLibraryLocation = CLLocation(latitude: 42.448078, longitude: -76.484291)


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var libraries : [Library]
    let mapView: MKMapView
    var locationManager: CLLocationManager!
    var userLocation: CLLocation?
    var libraryAnnotations : [MKPointAnnotation] = []
    
    var defaultCoordinate: CLLocationCoordinate2D {
        return locationManager.location?.coordinate ?? olinLibraryLocation.coordinate
    }
    
    init(libraries allLibraries : [Library]) {
        self.libraries = []
        self.mapView = MKMapView()
        super.init(nibName: nil, bundle: nil)
        
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            switch (CLLocationManager.authorizationStatus()) {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
            case .notDetermined:
                if locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
                    locationManager.requestWhenInUseAuthorization()
                }
            default: break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        /*navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Find Study Nooks"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage() */
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        /*
        let camera = GMSCameraPosition.camera(withLatitude: 42.4534, longitude: -76.4735, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.4534, longitude: -76.4735)
        marker.title = "Cornell University"
        marker.snippet = "New York"
        marker.map = mapView
    */

        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: defaultCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func mapLibraries(_ libraries: [Library]) {
        self.libraries = libraries
        
        for library in libraries {
            let annotationTitle = library.name
            let libraryAnnotation = MKPointAnnotation()
            libraryAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(library.location.coordinates[0]), longitude: Double(library.location.coordinates[1]))
            libraryAnnotation.title = annotationTitle
            libraryAnnotation.subtitle = library.isOpen ? "Open" : "Closed"
            mapView.addAnnotation(libraryAnnotation)
            libraryAnnotations.append(libraryAnnotation)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: defaultCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRendered = MKPolylineRenderer(polyline: mapView.overlays.first! as! MKPolyline)
        lineRendered.strokeColor = UIColor(red: 67/255, green: 170/255, blue: 233/255, alpha: 1)
        lineRendered.lineWidth = 3
        return lineRendered
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let newViewController = LibraryViewController(library: libraries[libraryAnnotations.index(of: view.annotation as! MKPointAnnotation) ?? 0])
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }

        let annotationView: MKAnnotationView

        if let dequeued = mapView.dequeueReusableAnnotationView(withIdentifier: "libraryPin") {
            annotationView = dequeued
            annotationView.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "libraryPin")
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        annotationView.image = annotation.subtitle == "Open" ? UIImage(named: "pin_open") : UIImage(named: "pin_closed")

        return annotationView
    }

    /*0
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
