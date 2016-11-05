//
//  VideoBroadcaster+CoreDataProperties.swift
//  
//
//  Created by Alex Golub on 10/29/16.
//
//

import Foundation
import CoreData

extension VideoBroadcaster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoBroadcaster> {
        return NSFetchRequest<VideoBroadcaster>(entityName: "VideoBroadcaster");
    }

    @NSManaged public var broadcasterID: String?
    @NSManaged public var imageID: String?
    @NSManaged public var title: String?
    @NSManaged public var events: NSSet?

}

// MARK: Generated accessors for events
extension VideoBroadcaster {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}
