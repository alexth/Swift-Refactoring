//
//  SeriesView.swift
//  StockCarBroadcastRemainder
//
//  Created by Alex Golub on 11/18/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class SeriesView: UIView {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    fileprivate var seriesArray = [Serie]()
    fileprivate var viewController: MainViewController!
    fileprivate let horizontalInset: CGFloat = 10.0
    fileprivate let verticalTopInset: CGFloat = 10.0
    fileprivate let imageViewHeight: CGFloat = 30.0
    fileprivate let buttonHeight: CGFloat = 50.0
    fileprivate let viewWidth: CGFloat = 240.0

    //MARK: - View Lifecycle

    init(subView viewController: MainViewController) {
        self.seriesArray = DatabaseManager.sharedInstance.series()
        self.viewController = viewController
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(frame: frame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupDataAndView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: - Setup

    func setupDataAndView() {
        heightConstraint.constant = CGFloat(self.seriesArray.count) * buttonHeight + verticalTopInset + imageViewHeight

        addShadow()
        addButtons()
        addDragImageView()
    }

    fileprivate func addButtons() {
        for (index, serie) in seriesArray.enumerated() {
            let button = UIButton(frame: CGRect(x: horizontalInset,
                                                y: verticalTopInset + (CGFloat(index) * buttonHeight),
                                                width: viewWidth - (horizontalInset * 2),
                                                height: buttonHeight))
            button.tag = index
            button.titleLabel?.text = serie.title
            button.backgroundColor = UIColor.green
            addSubview(button)
        }
    }

    fileprivate func addDragImageView() {
        let imageViewY = CGFloat(self.seriesArray.count) * buttonHeight + verticalTopInset + imageViewHeight
        let imageViewFrame = CGRect(x: 0.0, y: imageViewY, width: viewWidth, height: imageViewHeight)
        let imageView = UIImageView(frame: imageViewFrame)
        setupGestureRecognizer(dragImageView: imageView)
        addSubview(imageView)
    }

    fileprivate func setupGestureRecognizer(dragImageView: UIImageView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(imageViewDidDrag(recognizer:)))
        dragImageView.addGestureRecognizer(panGesture)
        dragImageView.isUserInteractionEnabled = true
    }

    @objc fileprivate func imageViewDidDrag(recognizer: UIPanGestureRecognizer) {
        guard recognizer.view != nil else { return }
        let translation = recognizer.translation(in: viewController.view)
        print(translation)
    }

    //MARK: - Actions


}
