//
//  LocalNotificationsManager.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

class LocalNotificationsManager {
//    class func createLocalNotification(_ event: Event, fireDate: Date, completion: () -> ()) {
//        let notificationTuple = isNotificationExist(event)
//        if notificationTuple.found == false {
//            let application = UIApplication.shared
//            
//            let localNotification = UILocalNotification()
//            localNotification.timeZone  = TimeZone.current
//            localNotification.fireDate = fireDate
//            localNotification.alertBody = "\(event.title!) broadcast starts at \(Date.formatEventDate(event))"
//            localNotification.alertAction = "View Race"
//            localNotification.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
//            localNotification.soundName = UILocalNotificationDefaultSoundName
//            localNotification.userInfo = [Notifications.eventDate : event.date!, Notifications.eventTitle : event.title!]
//            application.scheduleLocalNotification(localNotification)
//            
//            print("Notification set to \(fireDate)")
//            
//            print(application.scheduledLocalNotifications)
//        } else {
//            print("WARNING! Notification for event already set")
//        }
//        
//        completion()
//    }
//    
//    class func removeLocalNotification(_ event: Event, completion: () -> ()) {
//        let notificationTuple = isNotificationExist(event)
//        if notificationTuple.found == false {
//            let application = UIApplication.shared
//            application.cancelLocalNotification(notificationTuple.notification!)
//            print("Notification to \(event.date!) removed")
//        } else {
//            print("WARNING! No notification to remove")
//        }
//        
//        completion()
//    }
//    
//    class func isNotificationExist(_ event: Event) -> (found: Bool, notification: UILocalNotification?) {
//        let application = UIApplication.shared
//        let existingNotifications = application.scheduledLocalNotifications
//        for localNotification in existingNotifications! {
//            let eventDate = localNotification.userInfo![Notifications.eventDate] as! Date
//            let eventTitle = localNotification.userInfo![Notifications.eventTitle] as! String
//            if eventDate == event.date && eventTitle == event.title! {
//                return (true, localNotification)
//            }
//        }
//        
//        return (false, nil)
//    }
}
