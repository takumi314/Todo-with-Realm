//
//  LocationView.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/02.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import MapKit

protocol LocationViewDelegate {
    func didPressMap(_ location: CGPoint)
}

class LocationView: MKMapView {

    var tapDelegate: LocationViewDelegate?

    func addTrackingGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didPress(sender:)))
        addGestureRecognizer(gesture)
    }

    func setCenter(At point: CGPoint) {
        self.center = point
    }

    func setRect(_ size: CGSize) {
        self.bounds.size = size
    }

    func didPress(sender: UILongPressGestureRecognizer){
        if sender.minimumPressDuration == 0.5 {
            if sender.state == .ended {
                let location = sender.location(in: self)
                tapDelegate?.didPressMap(location)
            }
        }
    }

    func clearAnnotations() {
        removeAnnotations(annotations)
    }

}

extension LocationView: Nibable { }

extension LocationView: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("did tap a annotation")
    }

    

}
