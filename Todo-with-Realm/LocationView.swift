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

    func instantiate() -> LocationView {
        return LocationView()
    }

    func addGestureMonitoring() {
        let gesture = UIGestureRecognizer(target: self, action: #selector(didpress(sender:)) )
        self.addGestureRecognizer(gesture)
    }

    func setCenter(At point: CGPoint) {
        self.center = point
    }

    func setRect(_ size: CGSize) {
        self.bounds.size = size
    }


    func didpress(sender: UILongPressGestureRecognizer){
        if sender.numberOfTapsRequired == 1 && sender.minimumPressDuration > 0.5 {
            // 座標取得
            if sender.state == .ended {
                let location = sender.location(in: self)
                tapDelegate?.didPressMap(location)
            }
        }
    }

}

extension LocationView: Nibable {}
