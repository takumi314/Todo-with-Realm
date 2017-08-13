//
//  LocationCell.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/10.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import MapKit

protocol LocationCelldelegate {
    //
}

class LocationCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var mapView: MKMapView!

    // MSRK: - Public properties

    var delegate: LocationCelldelegate?


    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension LocationCell: CellIdentifiable {}

extension LocationCell {

    func didTapMap(_ sender: Any) {
        // デリゲート呼び出し
    }

}
