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

    enum selecter {
        case didTapSearchItem

        func selecter() -> Selector {
            switch self {
            case .didTapSearchItem:
                return #selector(MapViewController.didTapSearchItem)
            }
        }
    }

    struct Const {
        let address = "Address"
    }

    let const = Const()

    var map: LocationView?

    // MARK: - Private properties

    fileprivate var pinItems = [MKAnnotation]() {
        didSet {
            guard let map = self.map, pinItems.count > 0 else {
                return
            }
            map.showAnnotations(pinItems, animated: true)
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        view.addSubview(map!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: selecter.didTapSearchItem.selecter())
        self.navigationItem.rightBarButtonItems = [searchItem]
    }

    // MARK: - Private methods

    private func createMap() {
        map = LocationView()

        LocationListener.shared.delegate = self
        LocationListener.shared.ask().update()

        map?.region = setRegion(lat: 0.0, lon: 0.0)
        map?.setCenter(At: view.center)
        map?.setRect(view.bounds.size)
        map?.showsUserLocation = true
        map?.setUserTrackingMode(.followWithHeading, animated: true)
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

    fileprivate func setRegion(lat: CLLocationDegrees, lon: CLLocationDegrees) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        return MKCoordinateRegionMake(center, span)
    }

    private func close() {
        dismiss(animated: true) { [weak self] in
            LocationListener.shared.delegate = nil
            LocationListener.shared.close()
            self?.destoryMap()
        }
    }

    @objc fileprivate func didTapSearchItem() {
        let locationSearch = LocationSearchViewController.instantiate()
        locationSearch.region = map?.region
        locationSearch.adopt = { [weak self] completion in
            let request = MKLocalSearchRequest(completion: completion)
            self?.search(with: request)
            if let annotations = self?.pinItems {
                self?.map?.addAnnotations(annotations)
            }
        }
        locationSearch.modalPresentationStyle = .overCurrentContext
        locationSearch.modalTransitionStyle = .crossDissolve
        present(locationSearch, animated: true, completion: nil)
    }

    fileprivate func search(with request: MKLocalSearchRequest) {
        MKLocalSearch(request: request).start { [weak self] response, error in
            if error != nil {
                print("something is wrong")
                return
            }
            var annotaitons = [MKAnnotation]()
            response?.mapItems.forEach { item in
                let a = MKPointAnnotation()
                a.coordinate = item.placemark.coordinate
                a.title = item.placemark.name
                annotaitons.append(a)
            }
            self?.pinItems = annotaitons
        }
    }

}

// MARK: - MKMap

extension MapViewController {

    fileprivate func address(from location: CLLocation) {
        guard let map = map else {
            return
        }
        let position = location.coordinate
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks , error) in
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
        guard let map = map else {
            return
        }
        let geo = map.convert(location, toCoordinateFrom: map)
        let coodinates = CLLocation(latitude: geo.latitude, longitude: geo.longitude)
        address(from: coodinates)
    }

}

extension MapViewController: MKMapViewDelegate {}

extension MapViewController: LocationListenerDelegate {
    func didUpdateLocation() {
        guard let coodinate = LocationListener.shared.current?.coordinate else {
            return
        }
        let region = setRegion(lat: coodinate.latitude, lon: coodinate.longitude)
        map?.setRegion(region, animated: true)
    }

}
