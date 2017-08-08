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
    }

    static let shared = LocationListener()


    // MARK: - Internal properties

    var delegate: LocationListenerDelegate?

    var current: CLLocation? {
        get {
            return histories.last
        }
    }

    var coordinate: CLLocationCoordinate2D? {
        get {
            return current?.coordinate
        }
    }

    // MARK: - Configurations

    func ask() -> LocationListener {
        listen()
        update()
        return self
    }

    func around(_ accuracy: CLLocationAccuracy) -> LocationListener {
        manager.desiredAccuracy = accuracy
        return self
    }

    // MARK: - Executions

    func listen() {
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
                break
            }
        } else {
            print("位置情報サービスがONになっていないため利用できません。「設定」⇒「プライバシー」⇒「位置情報サービス」")
        }
    }

    func update() {
        if manager.delegate == nil {
            manager.delegate = self
        }
        if status == .off {
            print("status: off")
            return
        }
        status = .listening
        manager.startUpdatingLocation()
        print("start updating")
    }

    func dispose() {
        histories.removeAll()
        status = .standby
    }

    func close() {
        manager.delegate = nil
        status = .off
    }

    // MARK: - Private methods

    fileprivate var histories = [CLLocation]() {
        didSet {
            if histories.count > 10 {
                histories.removeFirst()
            }
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

    fileprivate func enableLocationRelatedFeatures() {
        if CLLocationManager.locationServicesEnabled() {

        }
        else {
            print("cannot enable service, please make sure the configuration.")
        }
    }

    fileprivate func disableLocationRelatedFeatures() {
        // off
    }

}


// MARK: - CLLocationManagerDelegate

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
            delegate?.didUpdateLocation()
        } else {
            manager.delegate = nil
        }
    }

}
