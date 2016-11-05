//
//  EventManager.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import EventKit

class EventManager {

//    class func createEventInCalendar(event: Event) -> String {
//        let store = EKEventStore()
//        store.requestAccessToEntityType(.Event) {(granted, error) in
//            if !granted {
//                return
//            }
//            
//            let newEvent = EKEvent(eventStore: store)
//            newEvent.title = newEvent.title
//            newEvent.startDate = event.date!
//            newEvent.calendar = store.defaultCalendarForNewEvents
//            do {
//                try store.saveEvent(newEvent, span: .ThisEvent, commit: true)
////                return event.eventIdentifier //save event id to access this particular event later
//            } catch {
//                // Display error to user
//            }
//        }
//    }
//    
//    class func deleteEventFromCalendar(eventID: String, completion: () -> ()) {
//        let store = EKEventStore()
//        store.requestAccessToEntityType(.Reminder) {(granted, error) in
//            if !granted { return }
//            let eventToRemove = store.eventWithIdentifier(eventID)
//            if eventToRemove != nil {
//                do {
//                    try store.removeEvent(eventToRemove!, span: .ThisEvent, commit: true)
//                } catch {
//                    // Display error to user
//                }
//            }
//        }
//    }
}
