//
//  TableViewController.swift
//  PickUpSoccer
//
//  Created by test on 2021-03-03.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import CoreData

struct post {
    let name1 : String!
    //let time : Date!
    //let postalcode  : String!
    //let adress : String!
    //let players : Int!
    
    
}

class TableViewController: UITableViewController {
    
    var posts = [post]() // an array of post stat we crete in struct
    var try12 : [NSManagedObject] = []

    //@IBOutlet weak var players: UILabel!
    //@IBOutlet weak var time: UILabel!
    //@IBOutlet weak var postalcode: UILabel!
    //@IBOutlet weak var adress: UILabel!
    //@IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let db = Firestore.firestore()
        db.collection("event").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil{
                for document in snapshot!.documents{
                    
                    let documentData = document // if we want just document name we donnt neeed .data90
                    let name1 = documentData
                    try12.append(name1)
                    self.posts.insert(post(name1: name1), at: 0)
                    self.tableView.reloadData()
                    print(documentData) // it conatins all infor
                }
            }
        }
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...

        let label1 = cell.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].name1
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
