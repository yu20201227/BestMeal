//
//  RegisterViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
// プログラムで取得できる値は、インスタンスを作成するのではなく関数を作ってそこから呼び出す。
// function(object)の形よりobject.function()の形を好む(引数ラベルを先に持ってくる）


import UIKit
import FirebaseAuth
import FirebaseDatabase
import Lottie

final class RegisterViewController: UIViewController, UITextFieldDelegate, showAlertProtocol {
    
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
            
            backImageView.image = R.image.backGroundImage()
            backImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var goStartMessageLabel: UILabel! {
        didSet {
            goStartMessageLabel.text = ScreenText.registerLabel
            goStartMessageLabel.font = .boldSystemFont(ofSize: 28.0)
        }
    }
    
    @IBOutlet private weak var alphaView: UIView!
    @IBOutlet private weak var goStartButton: UIButton! {
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
        // カーソルが自動的に次のTextFieldへ移動する
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if userEmailTextField.text!.isEmpty != true && passTextField.text!.count >= Numbers.smallestPassNumber { registerPermittedAnimation() }
        
        else if userEmailTextField.text!.isEmpty == true || passTextField.text!.isEmpty == true {
            occureVibration()
            canNotRegisterAlert()
            return
        }
        
        else if passTextField.text!.count <= Numbers.smallestPassNumber {
            occureVibration()
            tooShortPassAlert()
            return
        }
    }
}

extension RegisterViewController {
   private func occureVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

