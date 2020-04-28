//
//  LocationManager.swift
//  Wins
//
//  Created by Мурат Камалов on 29.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import CoreLocation
import UIKit

protocol LocationDelegate: class{
    func someError(error: Error?)
    func updateLocation(with region: String?)
}

class LocationManager: NSObject{
    var locationManager = CLLocationManager()
    
    weak var locationDelegate: LocationDelegate!
    
    init(delegate: LocationDelegate) {
        self.locationDelegate = delegate
    }
        
    func setUp() -> LocationGetStatus{
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestLocation()
        
        guard CLLocationManager.locationServicesEnabled() else { return .error }
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        return .locationIsGetting
    }
}

extension LocationManager: CLLocationManagerDelegate{
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationDelegate.someError(error: error)
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            self.locationDelegate.someError(error: nil)
            return
        }
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil, let placemarks = placemarks else{
                self.locationDelegate.someError(error: error)
                return
            }
            let adminArea = placemarks.first?.administrativeArea
            self.locationDelegate.updateLocation(with: adminArea)
        }
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestAlwaysAuthorization()
        default:
            break
        }
    }
}


enum LocationGetStatus{
    case locationIsGetting
    case error
}
