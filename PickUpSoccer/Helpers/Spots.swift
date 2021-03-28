//
//  Spots.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-03.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import Foundation
import Firebase

class Spots{
    
    var spotArray : [Spot] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    func loadData(completed:@escaping()->()){
        
        db.collection("event").addSnapshotListener{(querySnapshot, error) in
            guard error == nil else{
                print("error")
                return completed()
            }
            self.spotArray = []
            for document in querySnapshot!.documents{
                let spot = Spot(dictionary: document.data())
                spot.documentID=document.documentID
                self.spotArray.append(spot)
                
                //spot.documentID = documnet.
            }
            completed()
        }
    }
}
