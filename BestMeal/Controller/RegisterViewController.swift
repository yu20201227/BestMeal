//
//  RegisterViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField:UITextField!
    @IBOutlet weak var passTextField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(sender:UIButton){
        Auth.auth().createUser(withEmail: userEmailTextField.text!, password: passTextField.text!) { (result, error) in

            if result?.user != nil {
                //let saveProfile = SaveProfile
                self.performSegue(withIdentifier: "toSearch", sender: nil)
                
            }else{
                print(error.debugDescription)
            }
        }
    }
}
    

