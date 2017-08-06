//
//  LocationListener.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/05.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationListenerDelegate {
    func didUpdateLocation()
}

class LocationListener: NSObject {

    enum ListenStatus {
        case off
        case standby
        case listening
        case updated
    }

    static let shared = LocationListener()

    var delegate: LocationListenerDelegate?

    var current: CLLocation? {
        get {
            if status == .listening {
                return nil
            }
            return histories.last
        }
    }

    fileprivate var histories = [CLLocation]() {
        didSet {
            status = .standby
        }
    }

    fileprivate var status: ListenStatus = .off

    fileprivate let manager = CLLocationManager()

    fileprivate var auth: CLAuthorizationStatus {
        get {
            return CLLocationManager.authorizationStatus()
        }
    }

    private func isAvaliable() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    fileprivate func ask(_ handler: @escaping () -> Void) -> LocationListener {
        listen()
        while status == .listening {
            if handler == nil {
                break
            }
            print(current ?? "No data")
        }
        return self
    }

    fileprivate func listen() {
        if isAvaliable() {
            switch auth {
            case .restricted, .denied:
                status = .off
                break
            case .notDetermined:
                status = .off
                manager.requestWhenInUseAuthorization()
                break
            case .authorizedAlways, .authorizedWhenInUse:
                status = .standby
                update()
                break
            }
        }
        print("位置情報サービスがONになっていないため利用できません。「設定」⇒「プライバシー」⇒「位置情報サービス」")
    }

    fileprivate func update() {
        if manager.delegate == nil {
            manager.delegate = self
        }
        if status == .off {
            return
        }
        status = .listening
        manager.startUpdatingLocation()
    }

    func clear() {
        histories.removeAll()
        status = .standby
    }

    fileprivate func enableLocationRelatedFeatures() {
        if CLLocationManager.locationServicesEnabled() {
            // Get started.
            status = .standby
        } else {
            print("cannot enable service, please make sure the configuration.")
        }
    }

    fileprivate func disableLocationRelatedFeatures() {
        // off
    }

}

extension LocationListener {}

extension LocationListener: CLLocationManagerDelegate {

    /// This method is called whenever the application’s ability to use location services changes. 
    /// The location manager only reports changes to the authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authrization staus has changed: \(status)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            enableLocationRelatedFeatures()
            break
        case .denied, .restricted:
            disableLocationRelatedFeatures()
            break
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if status == .listening {
            locations.forEach { [weak self] location in
                self?.histories.append(location)
            }
            status = .standby
        }
    }

}
