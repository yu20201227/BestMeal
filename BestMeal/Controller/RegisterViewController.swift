//
//  RegisterViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Lottie

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmailTextField: UITextField! {
        didSet {
            userEmailTextField.delegate = self
            userEmailTextField.layer.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var passTextField: UITextField! {
        didSet {
            passTextField.delegate = self
            passTextField.layer.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            backImageView.image = UIImage(named: ImageName.registerBackImage)
            backImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var goStartMessageLabel: UILabel! {
        didSet {
            goStartMessageLabel.text = ScreenText.registerLabel
            goStartMessageLabel.font = .boldSystemFont(ofSize: 28.0)
        }
    }
    
    @IBOutlet weak var alphaView: UIView!
    
    @IBOutlet weak var goStartButton: UIButton! {
        didSet {
            goStartButton.layer.cornerRadius = 30.0
            goStartButton.titleLabel?.font = .boldSystemFont(ofSize: 26.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if userEmailTextField.text?.isEmpty != true && passTextField.text!.count >= Numbers.smallestPassNumber {
            registerPermittedAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [unowned self] in
                UserDefaults.standard.set(userEmailTextField.text, forKey: UserDefaultForKey.userEmail)
                UserDefaults.standard.set(passTextField.text, forKey: UserDefaultForKey.userPass)
                self.performSegue(withIdentifier: SegueIdentifier.toSearch, sender: nil)
            }
        }
        else if userEmailTextField.text?.isEmpty == true || passTextField.text!.isEmpty == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            canNotRegisterAlert()
            return
        }
        else if passTextField.text!.count <= Numbers.smallestPassNumber {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            tooShortPassAlert()
            return
        }
        
        // MARK: - closure
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
        }
    }
    
}
