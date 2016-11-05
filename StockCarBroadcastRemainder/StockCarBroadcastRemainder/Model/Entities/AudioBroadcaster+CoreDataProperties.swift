//
//  AudioBroadcaster+CoreDataProperties.swift
//  
//
//  Created by Alex Golub on 10/29/16.
//
//

import Foundation
import CoreData

extension AudioBroadcaster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AudioBroadcaster> {
        return NSFetchRequest<AudioBroadcaster>(entityName: "AudioBroadcaster");
    }

    @NSManaged public var broadcasterID: String?
    @NSManaged public var imageID: String?
    @NSManaged public var title: String?
    @NSManaged public var events: NSSet?

}

// MARK: Generated accessors for events
extension AudioBroadcaster {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}
