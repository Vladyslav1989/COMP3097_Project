//
//  Spot.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-03.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import Foundation
import Firebase
import MapKit
class Spot:NSObject,MKAnnotation{
    
    
    
    var name: String
    var adress: String
    var coordinate: CLLocationCoordinate2D
    var postalCode: String
    var numberPlayers: Int
    var time: Date
    var documentID : String
    
    
   
    var dictionary:[String: Any]{
        return["name":name,"adress":adress, "cordinates":coordinate,"time":time,"postal_code":postalCode,"num_players":numberPlayers]
    }
    
    var title: String?{
        return name
    }
    var subtitle: String?{
        return adress
    }
    
    
    init(name:String,adress:String, cordinate:CLLocationCoordinate2D,postalCode:String,numberPlayers:Int,time:Date,documentID:String) {
        self.postalCode = postalCode
        self.name = name
        self.adress = adress
        self.coordinate = cordinate
        self.numberPlayers = numberPlayers
        self.time = time
        self.documentID = documentID
        
        
    }
    convenience override init(){
        self.init(name:"",adress:"", cordinate:CLLocationCoordinate2D(),postalCode:"",numberPlayers:0,time:Date(),documentID:"")
    }
    
    convenience init(dictionary:[String: Any]){
        let point = dictionary["cordinates"] as? GeoPoint
        let lat =  point?.latitude as? Double ?? 0.0
        let alt =  point?.longitude as? Double ?? 0.0
        let name = dictionary["name"] as? String ?? ""
        let adress = dictionary["adress"] as? String ?? ""
        let postalCode = dictionary["postal_code"] as? String ?? ""
        let time = dictionary["time"] as? Date ?? Date()
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: alt)
        let numberPlayers = dictionary["num_players"] as? Int ?? 0// if we diddnt get string we wil get an empty string
        
        self.init(name:name, adress:adress, cordinate:coordinate,postalCode:postalCode,numberPlayers:numberPlayers, time:time,documentID:"")
    }
}
