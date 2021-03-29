//
//  HomeViewController.swift
//  PickUpSoccer
//
//  Created by Tech on 2021-02-26.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let db = Firestore.firestore() // referencing db
        
        /* // way to create colection or data manually
        db.collection("event").addDocument(data: ["name":"someevent","num_players":10]) { (error) in
            if error != nil{
                print("error ocure")
            }
         esle{
            // we added collecttion
         }
        }
        */
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
