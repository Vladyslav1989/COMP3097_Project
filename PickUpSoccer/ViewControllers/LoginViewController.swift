//
//  LoginViewController.swift
//  PickUpSoccer
//
//  Created by Tech on 2021-02-26.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emalTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var erorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElemnets()
    }
    func setUpElemnets(){
        erorLabel.alpha = 0 // hides error label
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO Validate Test Fields tah tehy are not empty
        
        
        //crete refrence to email nad password
        let email = emalTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Sighning in the user
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                //couldn sighn in
                self.erorLabel.text = error!.localizedDescription
                self.erorLabel.alpha = 1
            }
            else{
                let homeViewController  =  self.storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HomeViewController
                
                
                // swaping root view contorller
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
        
        
    }
    func transitionBac(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.startViewController) as? ViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func CanelTapp(_ sender: Any) {
        self.transitionBac()
    }
}
