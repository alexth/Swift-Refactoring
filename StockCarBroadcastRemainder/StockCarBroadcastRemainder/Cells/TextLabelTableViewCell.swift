//
//  TextLabelTableViewCell.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/30/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class TextLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellWithText(_ text: String) {
        label.text = text
    }
}
