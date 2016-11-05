//
//  BroadcastersTableViewCell.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/30/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class BroadcastersTableViewCell: UITableViewCell {

    @IBOutlet weak var videoBroadcasterImageView: UIImageView!
    @IBOutlet weak var audioBroadcasterImageView: UIImageView!
    @IBOutlet weak var videoBroadcasterlabel: UILabel!
    @IBOutlet weak var audioBroadcasterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(_ event: Event) {
//        let audioBroadcaster = event.audioBroadcasters
//        let videoBroadcaster = event.videoBroadcasters
    }

}
