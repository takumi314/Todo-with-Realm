//
//  MapViewController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/01.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    var map: LocationView?

    func instantiate() -> LocationView {
        return LocationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        map = LocationView()

        // 現在座標を取得
        let current = (35.690553, 139.699579)
        let region = setRegion(lat: current.0, lon: current.1)
        map?.setRegion(region, animated: true)
        map?.setCenter(At: view.center)
        map?.setRect(view.bounds.size)
        map?.addGestureMonitoring()
        map?.tapDelegate = self
        view.addSubview(map!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        map?.removeFromSuperview()
        map = nil
    }

    private func setRegion(lat: CLLocationDegrees, lon: CLLocationDegrees) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        return MKCoordinateRegionMake(center, span)
    }

    func address(from location: CLLocation) {
        guard let map = map else { return }
        let p = location.coordinate
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks , error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let placemarks = placemarks, placemarks.count > 0 {
                placemarks.forEach {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(p.latitude, p.longitude)
                    annotation.title = "Address"
                    annotation.subtitle = "\($0.administrativeArea!) \($0.locality!) \($0.thoroughfare!) \($0.subThoroughfare!)"
                    map.addAnnotation(annotation)
                }
            }
        }
    }

}

extension MapViewController: Storyboardable {}

extension MapViewController: LocationViewDelegate {

    func didPressMap(_ location: CGPoint) {
        guard let map = map else { return }
        let geo = map.convert(location, toCoordinateFrom: map)
        let coodinates = CLLocation(latitude: geo.latitude, longitude: geo.longitude)
        address(from: coodinates)
    }

}

extension MapViewController: MKMapViewDelegate { }
