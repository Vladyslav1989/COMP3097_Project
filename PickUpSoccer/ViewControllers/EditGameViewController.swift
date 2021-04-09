//
//  EditGameViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-04-02.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase

class EditGameViewController: UIViewController {

    
    @IBOutlet weak var numberPlayersTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var spot: Spot!
    override func viewDidLoad() {
        super.viewDidLoad()
        if spot == nil{
            spot = Spot()
        }
            updateUserInterface()
      
    }
    func transitionBac(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HomeViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
  
    @IBAction func cancelTap(_ sender: Any) {
        self.transitionBac()
    }
    
    
    func updateUserInterface(){
        
         nameTextField.text = spot.name
        numberPlayersTextField.text = String(spot.numberPlayers)
        //Int(numberPlayersTextField.text ?? "") == spot.numberPlayers
        
        
        
        
        
        
        
    }
   

    @IBAction func updateTap(_ sender: Any) {
        let db = Firestore.firestore()
        let eventName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let eventAdress = adressEvent.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let eventPostlCode = postcodeEvent.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let numplayers = Int(numberPlayersTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        db.collection("event").document(spot.documentID).updateData(["name" :eventName, "num_players":numplayers])
        self.transitionBac()
        /*
        db.collection("event").document(spot.documentID).getDocument { (document, err) in
            if err == nil {
                if document != nil && document!.exists{
                    
                    let documentData = document!.data()
                    print(documentData)
                }
            }
        }
        */
    }
}
