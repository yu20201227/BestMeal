//
//  PermitJudgeModel.swift
//  BestMeal
//
//  Created by Owner on 2021/02/09.
//

import Foundation
import MapKit

public class LocationPermission {
    public func locationManagerDidChange(manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        default:
            print("something error on the location permisssion")
        }
        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            break
        case .fullAccuracy:
            break
        default:
            print("something wrong")
        }
    }
}
