//
//  PermitJudgeModel.swift
//  BestMeal
//
//  Created by Owner on 2021/02/09.
//

import Foundation
import MapKit

@available(iOS 14.0, *)
public class LocationPermission {
    public func locationManagerDidChange(manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("許可されました")
            break
        case .denied:
            let url = URL(string: "app-settings:root=General&path=com.gekkado.lunascope")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            print("設定に飛びまーす")
            break
        default: print("something error on the location permisssion")
        }
        
        switch manager.accuracyAuthorization {
        case .reducedAccuracy, .fullAccuracy: break
        default: print("something wrong")
        }
    }
}
