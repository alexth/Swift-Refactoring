//
//  DatabaseManager.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 2/21/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    static let sharedInstance = DatabaseManager()
    fileprivate init() {}

    // MARK: - Core Data stack

    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StockCarBroadcastRemainder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension DatabaseManager {
    // MARK: - JSON Data Import
    func importData() {
        let fetchRequest: NSFetchRequest<Serie> = Serie.fetchRequest()
        do {
            let seriesArray = try managedObjectContext.fetch(fetchRequest)
            if seriesArray.count == 0 {
                setUpData()
            }
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
    }
    
    fileprivate func setUpData() {
        // Series
        let seriesDictionary: NSDictionary = parseJSON(name: "Series")
        let seriesArray = seriesDictionary["Series"] as! NSArray
        for serie in seriesArray {
            let serieDictionary = serie as! NSDictionary
            let newSerieEntity = NSEntityDescription.insertNewObject(forEntityName: "Serie", into: managedObjectContext) as! Serie
            newSerieEntity.title = serieDictionary["title"] as? String
            newSerieEntity.shortTitle = serieDictionary["short_title"] as? String
            newSerieEntity.imageID = serieDictionary["image_id"] as? String
            
            saveContext()
        }

        // Tracks
        let tracksDictionary: NSDictionary = parseJSON(name: "Tracks")
        let tracksArray = tracksDictionary["Tracks"] as! NSArray
        for track in tracksArray {
            let trackDictionary = track as! NSDictionary
            let newTrackEntity = NSEntityDescription.insertNewObject(forEntityName: "Track", into: managedObjectContext) as! Track
            newTrackEntity.title = trackDictionary["track_title"] as? String
            newTrackEntity.info = trackDictionary["info"] as? String
            newTrackEntity.imageID = trackDictionary["image_id"] as? String
            newTrackEntity.trackImageID = trackDictionary["track_image_id"] as? String
            // TODO:
            newTrackEntity.latitude = trackDictionary["latitude"] as! String
            newTrackEntity.longitude = trackDictionary["longitude"] as! String

            newTrackEntity.length = trackDictionary["length"] as! Int16 //;jasdf;jkhsdf
            newTrackEntity.city = trackDictionary["city"] as? String
            
            saveContext()
        }

        // Broadcasters
        let broadcastersDictionary: NSDictionary = parseJSON(name: "Broadcasters")
        for key in broadcastersDictionary.allKeys {
            let broadcasterKey = key as! String
            let broadcastersArray = broadcastersDictionary[broadcasterKey] as! NSArray
            for broadcaster in broadcastersArray {
                let broadcasterDictionary = broadcaster as! NSDictionary
                if broadcasterKey == "VideoBroadcasters" {
                    let newBroadcasterEntity = NSEntityDescription.insertNewObject(forEntityName: "VideoBroadcaster", into: managedObjectContext) as! VideoBroadcaster
                    newBroadcasterEntity.broadcasterID = broadcasterDictionary["broadcaster_id"] as? String
                    newBroadcasterEntity.title = broadcasterDictionary["title"] as? String
                    newBroadcasterEntity.imageID = broadcasterDictionary["image_id"] as? String
                } else if broadcasterKey == "AudioBroadcasters" {
                    let newBroadcasterEntity = NSEntityDescription.insertNewObject(forEntityName: "AudioBroadcaster", into: managedObjectContext) as! AudioBroadcaster
                    newBroadcasterEntity.broadcasterID = broadcasterDictionary["broadcaster_id"] as? String
                    newBroadcasterEntity.title = broadcasterDictionary["title"] as? String
                    newBroadcasterEntity.imageID = broadcasterDictionary["image_id"] as? String
                }
                saveContext()
            }
        }

        // Events
        let eventsDictionary: NSDictionary = parseJSON(name: "Events")
        for key in eventsDictionary.allKeys {
            let raceKey = key as! String
            let racesArray = eventsDictionary[raceKey] as! NSArray
            for race in racesArray {
                let raceDictionary = race as! NSDictionary
                let newEventEntity = NSEntityDescription.insertNewObject(forEntityName: "Event", into: managedObjectContext) as! Event
                newEventEntity.title = raceDictionary["race_title"] as? String
                newEventEntity.imageID = raceDictionary["image_id"] as? String
                // TODO:
                newEventEntity.serie = fetchSerie(name: raceKey)
                newEventEntity.track = fetchTrack(name: raceDictionary["track_title"] as! String)
                newEventEntity.date = Date.eventDateFromString(date: raceDictionary["date"] as! String, time: raceDictionary["time"] as! String) as NSDate?

//                print("\(raceDictionary["audio_broadcaster"]) - \(raceDictionary["video_broadcaster"])")
                // TODO:
//                newEventEntity.audioBroadcasters = [fetchAudioBroadcaster(raceDictionary["audio_broadcaster"] as! String)]
//                newEventEntity.videoBroadcasters = [fetchVideoBroadcaster(raceDictionary["video_broadcaster"] as! String)]
                print("000 - \(newEventEntity)")
                saveContext()
            }
        }
    }

    //MARK: - Single Fetch

    fileprivate func fetchSerie(name: String) -> Serie {
        let fetchRequest: NSFetchRequest<Serie> = Serie.fetchRequest()
        var serie: Serie!
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Serie", in: managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "shortTitle = %@", name)
        do {
            let seriesArray = try managedObjectContext.fetch(fetchRequest)
            if seriesArray.count == 1 {
                serie = seriesArray[0]
            }
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return serie
    }

    fileprivate func fetchTrack(name: String) -> Track {
        let fetchRequest: NSFetchRequest<Track> = Track.fetchRequest()
        var trackEntity: Track!
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Track", in: managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "title = %@", name)
        do {
            let trackArray = try managedObjectContext.fetch(fetchRequest)
            if trackArray.count == 1 {
                trackEntity = trackArray[0]
            }
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return trackEntity
    }
// TODO:
/*    fileprivate func fetchVideoBroadcaster(_ name: String!) -> VideoBroadcaster! {
        let fetchRequest = NSFetchRequest()
        var broadcasterEntity: VideoBroadcaster?
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "VideoBroadcaster", in: managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "broadcasterID = %@", name)
        print(name)
        do {
            let seriesArray = try managedObjectContext.fetch(fetchRequest)
            if seriesArray.count == 1 {
                broadcasterEntity = seriesArray[0] as? VideoBroadcasterEntity
                return broadcasterEntity!
            } else {
                let broadcaster = NSEntityDescription.insertNewObject(forEntityName: "VideoBroadcaster", into: managedObjectContext) as! VideoBroadcaster
                broadcaster.imageID = "tbd"
                broadcaster.title = "tbd"
                broadcaster.broadcasterID = "tbd"
                
                return broadcaster
            }
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        
        return broadcasterEntity!
    }
    
    fileprivate func fetchAudioBroadcaster(_ name: String!) -> AudioBroadcaster! {
        let fetchRequest = NSFetchRequest()
        var broadcasterEntity: AudioBroadcaster?
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "AudioBroadcaster", in: managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "broadcasterID = %@", name)
        do {
            let seriesArray = try managedObjectContext.fetch(fetchRequest)
            if seriesArray.count == 1 {
                broadcasterEntity = seriesArray[0] as? AudioBroadcasterEntity
                return broadcasterEntity!
            } else {
                let broadcaster = NSEntityDescription.insertNewObject(forEntityName: "AudioBroadcaster", into: managedObjectContext) as! AudioBroadcasterEntity
                broadcaster.imageID = "tbd"
                broadcaster.title = "tbd"
                broadcaster.broadcasterID = "tbd"
                
                return broadcaster
            }
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        
        return broadcasterEntity!
    } */

    //MARK: - Group fetch

    func currentWeekEvents() -> [Event] {
        var currentWeekEventsArray = [Event]()
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Event", in: managedObjectContext)

        let currentDate = Date()
        var weekDateComponent = DateComponents()
        weekDateComponent.day = 7
        let weekFromNowDate = (Calendar.current as NSCalendar).date(byAdding: weekDateComponent, to: currentDate, options: [])!

        let datePredicate = NSPredicate(format: "date > %@ AND date < %@", currentDate as CVarArg, weekFromNowDate as CVarArg)
        // TODO:
//        let selectedPredicate = NSPredicate(format: "serie.isSelected == true")
        let selectedPredicate = NSPredicate(format: "serie.isSelected == false")
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, selectedPredicate])
        fetchRequest.predicate = compoundPredicate

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        do {
            currentWeekEventsArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return currentWeekEventsArray
    }

    func futureEvents(afterEvent event: Event?) -> [Event] {
        var eventsArray = [Event]()

        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Event", in: managedObjectContext)

        let datePredicate: NSPredicate
        if event != nil {
            datePredicate = NSPredicate(format: "date > %@", event!.date!)
        } else {
            datePredicate = NSPredicate(format: "date > %@", Date() as CVarArg)
        }
        // TODO:
//        let selectedPredicate = NSPredicate(format: "serie.isSelected == true")
        let selectedPredicate = NSPredicate(format: "serie.isSelected == false")
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, selectedPredicate])
        fetchRequest.predicate = compoundPredicate

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
        do {
            eventsArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return eventsArray
    }

    func events() -> [Event] {
        var eventsArray = [Event]()
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Event", in: managedObjectContext)
        do {
            eventsArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return eventsArray 
    }

    func series() -> [Serie] {
        var seriesArray = [Serie]()
        let fetchRequest: NSFetchRequest<Serie> = Serie.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Serie", in: managedObjectContext)
        do {
            seriesArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return seriesArray
    }

    //MARK: - Utils

    fileprivate func parseJSON(name: String) -> NSDictionary! {
        var result: NSDictionary?
        if let filepath = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let jsonContents = try NSString(contentsOfFile: filepath, encoding: String.Encoding.utf8.rawValue)
                if let data = jsonContents.data(using: String.Encoding.utf8.rawValue) {
                    do {
                        result = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    } catch let error as NSError {
                        print(error)
                    }
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.json not found!
        }
        return result
    }
}
