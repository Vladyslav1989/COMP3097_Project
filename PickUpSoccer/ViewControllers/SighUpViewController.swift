//
//  SighUpViewController.swift
//  PickUpSoccer
//
//  Created by Tech on 2021-02-26.
//  Copyright © 2021 VladBordiug. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SighUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var Cancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        errorLabel.alpha = 0 //hides error label
    }
    
    // Check the fields and validate taht the data is correct. If evertyung is correct , this metod returns nill, otherways it return error and we can put taht msg and put in our error-label
    func validateFields() ->String?
    {
        //Check taht all fileds are filed in , removing all space with triminCharacters and cheking if fileds is emprty
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        //if everything is good above it will Check is password is secure
        //will implement it later
        
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupTapped(_ sender: Any) {
        
        //when signup buttom is fired we want to validate the fields
        let error = validateFields()
        
        // we check if erron not equal to nil , its mean taht we have an error
        if error != nil{
            // tsomething wrong with the fields show mesage
             showError(error!) // caling ShowEriir func
        }
            
        else{
            //create cleane version of the data without white spaces
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create User  ,(withEmail: email, password: password) email and password refrence from above
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil{
                    //there was an erro creating user
                    self.showError("Error creating user")
                }
                else{
                    // user was created , now store first and last anme
                    let db = Firestore.firestore() // if will return us firestore object , and we can call all our methods to , add data to database
                    
                    //"uid":result is auto generate key by firebase , result will store taht key asfter succesull creation of user in result.user.uid
                    db.collection("users").addDocument(data: ["first_name":firstName,"email":email,"last_name":lastName,"uid":result!.user.uid]){ (error) in
                        
                        if error != nil{
                            // Show error mesage
                            self.showError("Something went wrong with  fetching you data")
                        }
                    }
                        
                        //transition to home scren
                        self.transitionToHome()
                    
                }
            }
            
        }
        
        
        
        //Transition to home screen
        
    }
    
    func  showError(_ message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    func transitionToHome(){
        
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeViewController) as? HomeViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    func transitionBac(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.startViewController) as? ViewController
        
        
        // swaping root view contorller
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func CancelTapped(_ sender: Any) {
        self.transitionBac()
    }
    
}
