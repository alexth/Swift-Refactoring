//
//  NSDate+Formatting.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/10/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

extension Date {
    static func eventDateFromString(date: String, time: String) -> Date {
        if time != "tbd" {
            let calendar = Calendar.current
            let locale = Locale(identifier: "en-US")
            
            var eventTime: Date
            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            dateFormatter.dateFormat = "hh:mm a"
            eventTime = dateFormatter.date(from: time)!
            let hour = (calendar as NSCalendar).component(.hour, from: eventTime)
            
            var eventDate: Date
            dateFormatter.timeZone = TimeZone(abbreviation: "EST")
            dateFormatter.dateFormat = "yyyy MMMM dd"
            eventDate = dateFormatter.date(from: date)!
            let year = (calendar as NSCalendar).component(.year, from: eventDate)
            let month = (calendar as NSCalendar).component(.month, from: eventDate)
            let day = (calendar as NSCalendar).component(.day, from: eventDate)
            
            var finalDateComponents = DateComponents()
            finalDateComponents.year = year
            finalDateComponents.month = month
            finalDateComponents.day = day
            finalDateComponents.hour = hour
            
            return calendar.date(from: finalDateComponents)!
        }
        
        // TODO:
        return Date()
    }
    
    static func formatEventDate(event: Event) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, HH:mm"
        
        return dateFormatter.string(from: event.date! as Date)
    }
    
    static func shortFormatEventDate(event: Event) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, HH:mm"
        
        return dateFormatter.string(from: event.date! as Date)
    }
}
