//
//  EventTitleTableViewCell.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/30/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class EventTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(_ event: Event) {

    
    }

}
