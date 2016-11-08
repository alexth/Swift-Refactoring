//
//  SerieCell.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/5/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class SerieCell: UITableViewCell {
    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var serieTitleLabel: UILabel!
    @IBOutlet weak var serieShortTitleLabel: UILabel!

    func setCell(serie: Serie) {
        serieShortTitleLabel.text = serie.shortTitle
        serieTitleLabel.text = serie.title

        if serie.isSelected == false {
            if let serieImage = UIImage(named: serie.imageID!) {
                serieImageView.image = UIImage.convertToGrayScale(serieImage)

                backgroundColor = UIColor.black
                serieTitleLabel.textColor = UIColor.lightGray
                serieTitleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightLight)
                serieShortTitleLabel.textColor = UIColor.lightGray
                serieShortTitleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightLight)
            }
        } else {
            serieImageView.image = UIImage(named: serie.imageID!)

            backgroundColor = UIColor.lightGray
            serieTitleLabel.textColor = UIColor.black
            serieTitleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
            serieShortTitleLabel.textColor = UIColor.black
            serieShortTitleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightMedium)
        }
    }
}
