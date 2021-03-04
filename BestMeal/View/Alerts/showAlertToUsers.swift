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
        let noInfoAlert: UIAlertController = UIAlertController(title: AlertTitle.notRegistered, message: AlertMessage.seekOneMoreTime, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: AlertTitle.okMessage, style: .default, handler: {
              (_: UIAlertAction!) -> Void in
            print(AlertTitle.okMessage)
          })
          noInfoAlert.addAction(okAction)
          present(noInfoAlert, animated: true, completion: nil)
        return
      }

    public func tooShortPassAlert() {
        let notRegsitered = UIAlertController(title: AlertTitle.failedToSearch, message: AlertMessage.notEnoughPass, preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction(title: AlertTitle.okMessage, style: .default) { (action: UIAlertAction) in
            print(AlertTitle.okMessage)
        }
        notRegsitered.addAction(okAction)
        present(notRegsitered, animated: true, completion: nil)
        return
    }
    
    public func mainAlert() {
        let noInfoAlert: UIAlertController = UIAlertController(title: AlertTitle.failedGetData, message: AlertMessage.alertChangeKeyword, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: AlertTitle.okMessage, style: .default, handler: {
            (_: UIAlertAction!) -> Void in
            print(AlertTitle.okMessage)
        })
        noInfoAlert.addAction(okAction)
        present(noInfoAlert, animated: true, completion: nil)
        return
    }
    
    public func noKeyWordsAlert() {
        let UIAlert = UIAlertController(title: AlertTitle.failedToSearch, message: AlertMessage.keywordIsEmpty, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertTitle.okMessage, style: .default) { (_: UIAlertAction) in
            print(AlertTitle.okMessage)
        }
        UIAlert.addAction(okAction)
        present(UIAlert, animated: true, completion: nil)
        return
    }
}
