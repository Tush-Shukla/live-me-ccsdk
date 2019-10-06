//
//  LocationUtil.swift
//

import Foundation
import CoreLocation
import INTULocationManager

class LocationUtil: Any {
    
    static var shared = LocationUtil()
    
    private var requestId: INTULocationRequestID?
    
    private init(){}
    
    func getLocationName(
        latitude: Double,
        longitude: Double,
        completion: @escaping ((_ placemarks: [CLPlacemark]?, _ locationName: String, _ address: (name: String, street: String, city: String, country: String)) -> Void)) {
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            var locationName = ""
            var address: (name: String, street: String, city: String, country: String) = ("", "", "", "")
            if let placemark = placemarks?.last {
                if let name = placemark.name{
                    locationName.append(name)
                    address.name = name
                }
                if let street = placemark.thoroughfare {
                    locationName.append(", \(street)")
                    address.street = street
                }
                if let city = placemark.locality {
                    locationName.append(", \(city)")
                    address.city = city
                }
                if let country = placemark.country {
                    locationName.append(", \(country)")
                    address.country = country
                }
            }
            completion(placemarks,locationName, address)
        }
    }
    
    func getLocation(timeout: TimeInterval = 3.0, completion: ((_ location: CLLocation?)->Void)?, failed: (()->Void)?) {
        INTULocationManager.sharedInstance()
            .requestLocation(withDesiredAccuracy: .room, timeout: timeout, delayUntilAuthorized: true)
            { (location, accuracy, status) in
                
                switch status {
                case .servicesDenied, .servicesDisabled, .servicesRestricted:
                    failed?()
                case .success, .timedOut:
                    completion?(location)
                default:
                    return
                }
        }
    }
    
    func subscribeToContinuousLocationUpdates(completion: ((_ location: CLLocation?)->Void)?, failed: (()->Void)?) {
        self.requestId = INTULocationManager.sharedInstance().subscribeToLocationUpdates { (location, accuracy, status) in
            switch status {
            case .servicesDenied, .servicesDisabled, .servicesRestricted:
                failed?()
            case .success, .timedOut:
                completion?(location)
            default:
                return
            }
        }
    }
    
    func unsubscribeToContinuousLocationUpdates() {
        guard let id = self.requestId else {return}
        INTULocationManager.sharedInstance().cancelLocationRequest(id)
    }
}

// MARK: Location Checks
extension LocationUtil {
    func isGPSEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func isPermissionGranted() -> Bool {
        return [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
    
    func hasRequestedPermission() -> Bool {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    func requestPermission() {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
    }
}
