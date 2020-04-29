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
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//
//        self.locationManager.delegate = self
//        self.locationManager.requestWhenInUseAuthorization()
//
////        self.locationManager.requestLocation()
//
//        guard CLLocationManager.locationServicesEnabled() else { return .error }
//
//        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.allowsBackgroundLocationUpdates = false
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
        
        return .locationIsGetting
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
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
}


enum LocationGetStatus{
    case locationIsGetting
    case error
}
