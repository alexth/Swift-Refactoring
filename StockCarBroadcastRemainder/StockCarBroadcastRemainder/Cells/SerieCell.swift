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

    let serieTitleLeadingConstraintDefault: CGFloat = 10.0
    let serieShortTitleLeadingConstraintDefault: CGFloat = 10.0
    let checkboxWidthConstraintDefault: CGFloat = 34.0
    let serieTitleLeadingConstraintShrink: CGFloat = 0.0
    let serieShortTitleLeadingConstraintShrink: CGFloat = 0.0
    let checkboxWidthConstraintShrink: CGFloat = 0.0

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

//                UIView.animate(withDuration: 0.3, animations: { () -> Void in
//                    self.checkboxWidthConstraint.constant = self.checkboxWidthConstraintShrink
//                    self.serieTitleLeadingConstraint.constant = self.serieTitleLeadingConstraintShrink
//                    self.serieShortTitleLeadingConstraint.constant = self.serieShortTitleLeadingConstraintShrink
//                })
            }
        } else {
            serieImageView.image = UIImage(named: serie.imageID!)
            
            backgroundColor = UIColor.lightGray
            serieTitleLabel.textColor = UIColor.black
            serieTitleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
            serieShortTitleLabel.textColor = UIColor.black
            serieShortTitleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightMedium)
            
//            UIView.animate(withDuration: 0.3, animations: { () -> Void in
//                self.checkboxWidthConstraint.constant = self.checkboxWidthConstraintDefault
//                self.serieTitleLeadingConstraint.constant = self.serieTitleLeadingConstraintDefault
//                self.serieShortTitleLeadingConstraint.constant = self.serieShortTitleLeadingConstraintDefault
//            })
        }
    }
}
