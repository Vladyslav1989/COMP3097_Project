//
//  EditViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-04-02.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {
    var spots: Spots!
    var filtereData = [Spot]()
    var count :Int = 0;
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spots = Spots()
        tableView.delegate = self
        tableView.dataSource = self
        filtereData = []
        

    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        spots.loadData {
            let userID = Auth.auth().currentUser?.uid
            
            for s in self.spots.spotArray
            {
                if(s.user_id == userID)
                {
                     self.filtereData.append(s)
                    
                }
                
          
               
            }
            
            self.tableView.reloadData()
             
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditGame" {
            let destination = segue.destination as! EditGameViewController
            let selectedIndexPath =  tableView.indexPathForSelectedRow!
            destination.spot = filtereData[selectedIndexPath.row]
        }
    }

    func transitionBac(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HomeViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
   
    @IBAction func canelTapp(_ sender: Any) {
        self.transitionBac()
    }
    
    

}
extension EditViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filtereData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userID = Auth.auth().currentUser?.uid
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditTableViewCell
        if(filtereData[indexPath.row].user_id == userID ){
            cell.nameLabel?.text = filtereData[indexPath.row].name
            
            
        }
        
        return cell
    }
    
    
}
