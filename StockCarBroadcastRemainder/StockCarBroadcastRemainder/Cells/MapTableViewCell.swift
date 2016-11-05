//
//  MapTableViewCell.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/30/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMapCell(_ altitude: CGFloat, longitude: CGFloat) {
        
    }
}
