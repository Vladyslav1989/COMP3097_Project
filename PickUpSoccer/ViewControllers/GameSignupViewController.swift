//
//  GameSignupViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-03.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces


class GameSignupViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var numplayersLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
  
    var spot: Spot!
    var cord = CLLocationCoordinate2D()
    var LocatioManger : CLLocationManager!
    
    let regionDistance:CLLocationDegrees = 750.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Cordinates are : \(spot.coordinate)")
        if spot == nil{
            spot = Spot()
        }
        setupMapView()
        updateUserInterface()

        // Do any additional setup after loading the view.
    }
    
    func setupMapView(){
        let region = MKCoordinateRegion(center: spot.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
    }
    func updateUserInterface(){
        gameLabel.text = spot.name
        adressLabel.text = spot.adress
        numplayersLabel.text = "Players Allowed:\(spot.numberPlayers)"
        
        timeLabel.text = "Date/Time \(spot.time)"
        updateMap()
        
        
        
    }
    func updateMap(){
       mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(spot)
        mapView.setCenter(spot.coordinate, animated: true)
        
    }
    
  
    @IBAction func getTapped(_ sender: Any) {
        self.cord = spot.coordinate
        performSegue(withIdentifier: "ShowDirections", sender: self)
    }
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DirectionViewController
        vc.directCord = self.cord
    }
    
    




}
// we dont need it here
/*
extension GameSignupViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       // print("Place name: \(place.name)")
       // print("Place ID: \(place.placeID)")
        //print("Place attributions: \(place.attributions)")
        spot.name = place.name ?? "Unkown"
        spot.adress = place.formattedAddress ?? "unkown Adress"
        spot.coordinate = place.coordinate
       //print("cordinates: \(place.coordinate)")
        updateUserInterface()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
*/


