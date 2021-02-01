//
//  RegisterViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var userEmailTextField:UITextField!
    @IBOutlet weak var passTextField:UITextField!
    
    var smallestPassCount = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        userEmailTextField.delegate = self
        passTextField.delegate = self
        userEmailTextField.layer.cornerRadius = 20.0
        passTextField.layer.cornerRadius = 20.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    @IBAction func registerButton(sender:UIButton){
        if userEmailTextField.text?.isEmpty == true || passTextField.text!.isEmpty == true {
            showAlert()
            return
        }
        
        if passTextField.text!.count <= smallestPassCount {
            let notRegsitered = UIAlertController(title: "登録できません。", message: "パスワードは6文字以上にしてください", preferredStyle: .alert)
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                print("OK")
            }
            notRegsitered.addAction(okAction)
            present(notRegsitered, animated: true, completion: nil)
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
//                let userPass = user.uid
//                UserDefaults.standard.set(userPass, forKey: "userPass")
                let saveProfile = SaveProfile(userEmail: self.userEmailTextField.text!, userPass: self.passTextField.text!)
                saveProfile.saveProfile()
                //self.dismiss(animated: true, completion: nil)
            } else {
                print(err?.localizedDescription as Any)
                return
            }
            self.performSegue(withIdentifier: "toSearch", sender: nil)
        }
    }

    func showAlert(){
        let noInfoAlert:UIAlertController = UIAlertController(title: "登録できません🙇‍♂️", message: "もう一度やり直してください", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        noInfoAlert.addAction(okAction)
        present(noInfoAlert, animated: true, completion: nil)
    }
}
