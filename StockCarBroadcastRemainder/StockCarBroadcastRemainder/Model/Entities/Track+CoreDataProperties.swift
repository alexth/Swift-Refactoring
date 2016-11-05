//
//  Track+CoreDataProperties.swift
//  
//
//  Created by Alex Golub on 10/29/16.
//
//

import Foundation
import CoreData

extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track");
    }

    @NSManaged public var city: String?
    @NSManaged public var imageID: String?
    @NSManaged public var info: String?
    @NSManaged public var latitude: String
    @NSManaged public var length: Int16
    @NSManaged public var longitude: String
    @NSManaged public var title: String?
    @NSManaged public var trackImageID: String?
    @NSManaged public var events: NSSet?

}

// MARK: Generated accessors for events
extension Track {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}
