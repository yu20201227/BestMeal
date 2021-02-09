//
//  showAlertToUsers.swift
//  BestMeal
//
//  Created by Owner on 2021/02/07.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func canNotRegisterAlert() {
          let noInfoAlert: UIAlertController = UIAlertController(title: "登録できません🙇‍♂️", message: "もう一度やり直してください", preferredStyle: .alert)
          let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
              (action: UIAlertAction!) -> Void in
              print("OK")
          })
          noInfoAlert.addAction(okAction)
          present(noInfoAlert, animated: true, completion: nil)
        return
      }

    
    public func tooShortPassAlert() {
        let notRegsitered = UIAlertController(title: "登録できません。", message: "パスワードは6文字以上にしてください", preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            print("OK")
        }
        notRegsitered.addAction(okAction)
        present(notRegsitered, animated: true, completion: nil)
        return
    }
    
    public func mainAlert() {
        let noInfoAlert: UIAlertController = UIAlertController(title: "情報を取得できません🙇‍♂️", message: "違うキーワードで検索してください！", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        noInfoAlert.addAction(okAction)
        present(noInfoAlert, animated: true, completion: nil)
        return
    }
    
    public func noKeyWordsAlert() {
        let UIAlert = UIAlertController(title: "検索できません。", message: "キーワードを入れてください！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            print("OK")
        }
        UIAlert.addAction(okAction)
        present(UIAlert, animated: true, completion: nil)
        return
        
    }
}
