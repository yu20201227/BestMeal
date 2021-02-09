//
//  RegisterViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var smallestPassCount = 6
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var goStartMessageLabel: UILabel!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var goStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goStartButton.backgroundColor = .gray
        goStartButton.layer.cornerRadius = 30.0
        goStartButton.titleLabel?.font = .boldSystemFont(ofSize: 26.0)
        goStartMessageLabel.text = "登録してはじめよう。"
        goStartMessageLabel.font = .boldSystemFont(ofSize: 28.0)
        goStartMessageLabel.textColor = .black
        backImageView.image = UIImage(named: "backimage")
        backImageView.contentMode = .scaleAspectFill
        backImageView.alpha = 1
        alphaView.alpha = 0.7
        view.backgroundColor = .black
        userEmailTextField.delegate = self
        passTextField.delegate = self
        userEmailTextField.layer.cornerRadius = 20.0
        passTextField.layer.cornerRadius = 20.0
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    @IBAction func registerButton(sender: UIButton) {
        if userEmailTextField.text?.isEmpty == true || passTextField.text!.isEmpty == true {
            canNotRegisterAlert()
            return
        }
        
        if passTextField.text!.count <= smallestPassCount {
            tooShortPassAlert()
            return
        }
        
        if userEmailTextField.text?.isEmpty != true && passTextField.text?.isEmpty != nil {
            UserDefaults.standard.set(userEmailTextField.text, forKey: "userEmail")
            UserDefaults.standard.set(passTextField.text, forKey: "userPass")
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            print("振動")
            return
        }
        
        Auth.auth().signInAnonymously { (result, err) in
            if err == nil {
                guard let _ = result?.user else { return }
                let saveProfile = SaveProfile(userEmail: self.userEmailTextField.text!, userPass: self.passTextField.text!)
                saveProfile.saveProfile()
                // self.dismiss(animated: true, completion: nil)
            } else {
                print(err?.localizedDescription as Any)
                return
            }
            self.performSegue(withIdentifier: "toSearch", sender: nil)
        }
    }
}
