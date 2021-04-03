//
//  PickUpsViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-02.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase

class PickUpsViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var spots: Spots!
    var filtereData = [Spot]()
    var UNfiltereData = [Spot]()
    var serchActive:Bool  = false
    
  
    override func viewDidLoad() {
        print("first")
        super.viewDidLoad()
        spots = Spots()
        tabelView.delegate = self
        tabelView.dataSource = self
        searchBar.delegate = self
        filtereData = spots.spotArray
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("when")
        super.viewDidAppear(animated)
        spots.loadData {
            self.tabelView.reloadData()
        }
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGame" {
            let destination = segue.destination as! GameSignupViewController
            let selectedIndexPath =  tabelView.indexPathForSelectedRow!
            destination.spot = spots.spotArray[selectedIndexPath.row]
        }
    }
    func transitionBac(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HomeViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func backtapp(_ sender: Any) {
        self.transitionBac()
    }
    
}

extension PickUpsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if(serchActive == false)
       {
        print("one")
        filtereData = spots.spotArray
        }
        print("two")
        return filtereData.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tabelView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GameTableViewCell
        cell.nameLabel.text = filtereData[indexPath.row].name
        return cell 
    }
    
    //search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty){
           filtereData = spots.spotArray
            print("here")
        } else {
            serchActive = true
        filtereData = spots.spotArray.filter({(text) -> Bool in
            
            let  temp: NSString = text.name as NSString
            
            
            let range = temp.range(of:searchText,options: NSString.CompareOptions.caseInsensitive)
            print("there")
            return range.location != NSNotFound
           
        })
        }
        self.tabelView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
    
    
}
 


/* // should be inside viewdid contoleer
 let db = Firestore.firestore()
 db.collection("event").getDocuments { (snapshot, error) in
 if error == nil && snapshot != nil{
 for document in snapshot!.documents{
 
 let documentData = document.data() // if we want just document name we donnt neeed .data90
 print(documentData) // it conatins all infor
 }
 }
 }
 
 */
