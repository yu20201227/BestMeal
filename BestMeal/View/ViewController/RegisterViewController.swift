//
//  RegisterViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
// プログラムで取得できる値は、インスタンスを作成するのではなく関数を作ってそこから呼び出す。
// function(object)の形よりobject.function()の形を好む(引数ラベルを先に持ってくる）


import UIKit
import Lottie

final class RegisterViewController: BaseViewController, UITextFieldDelegate, showAlertProtocol {
        
    @IBOutlet private weak var userEmailTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var goStartMessageLabel: UILabel!
    @IBOutlet private weak var alphaView: UIView!
    @IBOutlet private weak var goStartButton: UIButton!
    
    private var presenter: RegisterPresenter = RegisterViewPresenter()
    
    override func setup() {
        userEmailTextField.delegate = self
        userEmailTextField.layer.cornerRadius = 20.0
        passTextField.delegate = self
        passTextField.layer.cornerRadius = 20.0
        backImageView.image = R.image.backGroundImage()
        backImageView.contentMode = .scaleAspectFill
        goStartMessageLabel.text = ScreenText.registerLabel
        goStartMessageLabel.font = .boldSystemFont(ofSize: 28.0)
        goStartButton.layer.cornerRadius = 30.0
        goStartButton.titleLabel?.font = .boldSystemFont(ofSize: 26.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    
    // 振動でエラーを知らせる
    private func occureVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    private func registerPermittedAnimation() {
        
        let permitAnimationPath = Bundle.main.path(forResource: ForSourceType.registerPermitAnimation, ofType: FileType.jsonType)
        let animationView = AnimationView(filePath: permitAnimationPath!)
        animationView.animationSpeed = 1.0
        animationView.center = self.view.center
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationView.loopMode = .playOnce
        animationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [unowned self] in
            UserDefaults.standard.set(userEmailTextField.text, forKey: UserDefaultForKey.userEmail)
            UserDefaults.standard.set(passTextField.text, forKey: UserDefaultForKey.userPass)
            // 画面遷移
            self.presenter.gotoSearchScreen(self)
        }
        view.addSubview(animationView)
    }
}
