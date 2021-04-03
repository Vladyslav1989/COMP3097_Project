//
//  DirectionViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-05.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import MapKit

class DirectionViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapkitView: MKMapView!
    
    var directCord = CLLocationCoordinate2D()
    
     let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("coordinates:!!! \(directCord)")
      
        
        
        mapkitView.delegate = self
        mapkitView.showsScale = true
        mapkitView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        let sourceCordinates = locationManager.location?.coordinate
        print(sourceCordinates)
        
        let destCordinates = directCord
        let sourcePlacemark = MKPlacemark(coordinate: sourceCordinates!)
        let destinationPlacemark = MKPlacemark(coordinate: destCordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .any
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler:{
            response ,error in
        guard let response = response else {
            if let error = error{
                print("Something happen")
            }
            return
        }
         let route = response.routes[0]
        self.mapkitView.addOverlay(route.polyline, level: .aboveRoads)
            let rekt = route.polyline.boundingMapRect
            self.mapkitView.setRegion(MKCoordinateRegion(rekt), animated: true)
        })
        
        

        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.blue
        render.lineWidth =  5.0
        return render
    }
    func transitionBac(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.listViewController) as? PickUpsViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }


    @IBAction func backTapped(_ sender: Any) {
        self.transitionBac()
    }
    

}
