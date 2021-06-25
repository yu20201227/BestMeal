//
//  RegisterViewPresenter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/05.
//

import Foundation

/// ユーザーネーム登録
/// ユーザーメールアドレス登録
/// 登録成功
/// 登録失敗
protocol RegisterPresenter {
    
    func registerUserName()
    func registerUserMailAddress()
    
    func updateScreenBySuccess()
    func showAlertByFailure()
    
    func gotoSearchScreen(_ view: RegisterViewController)
}

class RegisterViewPresenter: RegisterPresenter {
    
    var interactor: RegisterUseCase = RegisterInteractor()
    var router: RegisterWireFrame = RegisterRouter()
    
    func registerUserName() {
        
    }
    
    func registerUserMailAddress() {
        
    }
    
    func updateScreenBySuccess() {
        
    }
    
    func showAlertByFailure() {
        
    }
    
    func gotoSearchScreen(_ view: RegisterViewController) {
        self.router.toSearchToken(view)
    }
    

}
