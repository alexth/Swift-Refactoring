//
//  Event+CoreDataProperties.swift
//  
//
//  Created by Alex Golub on 10/29/16.
//
//

import Foundation
import CoreData

extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var imageID: String?
    @NSManaged public var isReminderSet: Bool
    @NSManaged public var title: String?
    @NSManaged public var audioBroadcasters: NSSet?
    @NSManaged public var serie: Serie?
    @NSManaged public var track: Track?
    @NSManaged public var videoBroadcasters: NSSet?

}

// MARK: Generated accessors for audioBroadcasters
extension Event {

    @objc(addAudioBroadcastersObject:)
    @NSManaged public func addToAudioBroadcasters(_ value: AudioBroadcaster)

    @objc(removeAudioBroadcastersObject:)
    @NSManaged public func removeFromAudioBroadcasters(_ value: AudioBroadcaster)

    @objc(addAudioBroadcasters:)
    @NSManaged public func addToAudioBroadcasters(_ values: NSSet)

    @objc(removeAudioBroadcasters:)
    @NSManaged public func removeFromAudioBroadcasters(_ values: NSSet)

}

// MARK: Generated accessors for videoBroadcasters
extension Event {

    @objc(addVideoBroadcastersObject:)
    @NSManaged public func addToVideoBroadcasters(_ value: VideoBroadcaster)

    @objc(removeVideoBroadcastersObject:)
    @NSManaged public func removeFromVideoBroadcasters(_ value: VideoBroadcaster)

    @objc(addVideoBroadcasters:)
    @NSManaged public func addToVideoBroadcasters(_ values: NSSet)

    @objc(removeVideoBroadcasters:)
    @NSManaged public func removeFromVideoBroadcasters(_ values: NSSet)

}
