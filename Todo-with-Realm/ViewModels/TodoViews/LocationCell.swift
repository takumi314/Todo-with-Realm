//
//  LocationCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/10.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var mapView: MKMapView!

}

extension LocationCell: CellIdentifiable {}
