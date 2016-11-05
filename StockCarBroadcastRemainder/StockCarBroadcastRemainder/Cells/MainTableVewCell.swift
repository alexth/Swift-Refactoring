//
//  MainTableVewCell.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 2/29/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serieLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var videoBroadcasterLabel: UILabel!
//    @IBOutlet weak var audioBroadcasterLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
//    @IBOutlet weak var reminderStatusButton: UIButton!

    weak var delegate: MainTableViewCellDelegate?

    var cellEvent: Event!

    func cellWithEvent(event: Event) {
        cellEvent = event

        eventImageView.image = UIImage(named: event.imageID!)
        dateLabel.text = Date.formatEventDate(event: event)
        titleLabel.text = event.title
        serieLabel.text = event.serie!.shortTitle
        trackLabel.text = event.track!.title
        // TODO:
//        let videoBroadcastersArray = event.videoBroadcasters!.allObjects as! [VideoBroadcaster]
//        if videoBroadcastersArray.count > 0 {
//            let broadcasterString = videoBroadcastersArray[0].title!
//            videoBroadcasterLabel.text = "video: \(broadcasterString)"
//        }
//        
//        let audioBroadcastersArray = event.audioBroadcasters!.allObjects as! [AudioBroadcaster]
//        if audioBroadcastersArray.count > 0 {
//            let broadcasterString = audioBroadcastersArray[0].title!
//            audioBroadcasterLabel.text = "audio: \(broadcasterString)"
//        }
    }

    @IBAction func reminderStatusButtonDidPressed(_ sender: UIButton) {
        if cellEvent.isReminderSet == true {
//            LocalNotificationsManager.removeLocalNotification(cellEvent!, completion: {
//                self.cellEvent!.isReminderSet = false
//                DatabaseManager.sharedInstance.saveContext()
//                self.setReminderStatusButtonImage()
//            })
        } else {
            delegate?.displayPicker(forEvent: cellEvent, cell: self)
        }
    }

    func setReminderStatusButtonImage()  {
        // TODO:
//        if cellEvent.isReminderSet == true {
//            reminderStatusButton.setImage(UIImage(named: "checkbox_on"), for: UIControlState())
//        } else {
//            reminderStatusButton.setImage(UIImage(named: "checkbox_off"), for: UIControlState())
//        }
    }
}

protocol MainTableViewCellDelegate: class {
    func displayPicker(forEvent event: Event, cell: MainTableViewCell)
}
