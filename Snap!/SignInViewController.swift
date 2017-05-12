//
//  SignInViewController.swift
//  Snap!
//
//  Created by Bradley Stovall on 5/5/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    // Button for initial screen sign in
    @IBAction func goTapped(_ sender: Any) {
        // Sign In
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("We have an error:\(String(describing: error))")
                
                // Create User
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create user")
                    
                    if error != nil {
                        print("We have an error:\(String(describing: error))")
                    } else {
                        print("Created User Succesfully")
                // Saving users
                        
                FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print("Signed in Succesfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
    }
    
    
}

