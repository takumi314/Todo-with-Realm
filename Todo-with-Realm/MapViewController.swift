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

    struct Const {
        let address = "Adress"
    }

    let const = Const()

    var map: LocationView?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        view.addSubview(map!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        destoryMap()
    }

    // MARK: - Private methods

    private func createMap() {
        map = LocationView()

        let current = (35.690553, 139.699579)
        let region = setRegion(lat: current.0, lon: current.1)
        map?.setRegion(region, animated: true)
        map?.setCenter(At: view.center)
        map?.setRect(view.bounds.size)
        map?.addTrackingGesture()
        map?.tapDelegate = self
        map?.delegate = map
    }

    private func destoryMap() {
        map?.tapDelegate = nil
        map?.delegate = nil
        map?.clearAnnotations()
        map?.removeFromSuperview()
        map = nil
    }

    private func setRegion(lat: CLLocationDegrees, lon: CLLocationDegrees) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        return MKCoordinateRegionMake(center, span)
    }

    private func close() {
        dismiss(animated: true, completion:nil)
    }

}

// MARK: - MKMap

extension MapViewController {

    fileprivate func address(from location: CLLocation) {
        guard let map = map else { return }
        let position = location.coordinate
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks , error) in
            guard let this = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            if let placemarks = placemarks, placemarks.count > 0 {
                let annotations = this.showAnnotations(placemarks, on: position)
                map.addAnnotations(annotations)
            }
        }
    }

    private func showAnnotations(_ placemarks: [CLPlacemark],on location: CLLocationCoordinate2D) -> [MKPointAnnotation] {
        print(placemarks)
        return placemarks.flatMap({ [weak self] placemark in
            guard let this = self else { return nil }
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            annotation.title = this.const.address
            annotation.subtitle = this.subtitle(from: placemark)
            return annotation
        })
    }

    private func subtitle(from mark: CLPlacemark) -> String {
        return (mark.administrativeArea ?? " ")
            + (mark.locality ?? " ")
            + (mark.thoroughfare ?? " ")
            + (mark.subThoroughfare ?? "")
    }

}

// MARK: - Storyboardable

extension MapViewController: Storyboardable {}

// MARK: - LocationViewDelegate

extension MapViewController: LocationViewDelegate {

    func didPressMap(_ location: CGPoint) {
        guard let map = map else { return }
        let geo = map.convert(location, toCoordinateFrom: map)
        let coodinates = CLLocation(latitude: geo.latitude, longitude: geo.longitude)
        address(from: coodinates)
    }

}

extension MapViewController: MKMapViewDelegate { }
