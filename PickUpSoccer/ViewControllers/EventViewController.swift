//
//  EventViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-02.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GooglePlaces


class EventViewController: UIViewController {
    var longitude : Double!
    var latitude : Double!
    var adress : String!
    
    private var datePicker: UIDatePicker?
    
    @IBOutlet weak var nameEvent: UITextField!
    @IBOutlet weak var nunPlayersEvnt: UITextField!
    //@IBOutlet weak var postcodeEvent: UITextField!
    //@IBOutlet weak var adressEvent: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var dateEvent: UITextField!
    @IBOutlet weak var eventAdress: UITextField!
    
    override func viewDidLoad() {
        
        
        setUpElements()
        
        
        
        
        
        
        
        super.viewDidLoad()
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for:.valueChanged )
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateEvent.inputView = datePicker // will bring datePicker if i pree on dateField
        // Do any additional setup after loading the view.
    }
    
    // this is selector funcetoin to recofnize tapped action and close datepicker even if date is not selected
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    // this is selector function for datepicker to select date
    @objc func dateChanged(datePicker: UIDatePicker){
        
        // TODO need to find right format     link https://developer.apple.com/documentation/foundation/dateformatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy'AT'HH:mm"
        dateEvent.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true) // this way to close datepicker
        
       // datePicker.date //it will date taht user select in picker
        
    }
    

    func setUpElements(){
        error.alpha = 0 //hides error label
    }
    func  showError(_ message:String){
        
        error.text = message
        error.alpha = 1
        
    }
    func transitionToHome(){
        
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HomeViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    // Check the fields and validate taht the data is correct. If evertyung is correct , this metod returns nill, otherways it return error and we can put taht msg and put in our error-label
    func validateFields() ->String?
    {
        //Check taht all fileds are filed in , removing all space with triminCharacters and cheking if fileds is emprty
        if nameEvent.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nunPlayersEvnt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            eventAdress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dateEvent.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        //if everything is good above it will Check is password is secure
        //will implement it later
        
        return nil
    }

    @IBAction func createEvent(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        //when signup buttom is fired we want to validate the fields
        let error = validateFields()
        
        // we check if erron not equal to nil , its mean taht we have an error
        if error != nil{
            // tsomething wrong with the fields show mesage
            showError(error!) // caling ShowEriir func
        }
            
        else{
            //create cleane version of the data without white spaces
            
            let eventName = nameEvent.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //let eventAdress = adressEvent.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //let eventPostlCode = postcodeEvent.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let eventNumPlayers = nunPlayersEvnt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let eventDate = dateEvent.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
           
            
                    let db = Firestore.firestore() // if will return us firestore object , and we can call all our methods to , add data to database
                    
                    //add data to document
            db.collection("event").addDocument(data: ["name":eventName,"adress":adress,"num_players":eventNumPlayers,"time":eventDate,"cordinates":GeoPoint(latitude: latitude, longitude: longitude)])
                        
        
            
        
    
    }
    }


    
    @IBAction func Adress(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
        
        
    }
    
  
    
}
extension EventViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       // print("Place name: \(place.name)")
       // print("Place ID: \(place.placeID)")
         //print("Place Adress: \(place.formattedAddress)")
        //print("Place attributions: \(place.attributions)")
        //spot.name = place.name ?? "Unkown"
        //spot.adress = place.formattedAddress ?? "unkown Adress"
        longitude = place.coordinate.longitude
        latitude = place.coordinate.latitude
        adress = place.formattedAddress
        eventAdress.text = adress
        print("cordinates: \(place.coordinate)")
        //updateUserInterface()
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
