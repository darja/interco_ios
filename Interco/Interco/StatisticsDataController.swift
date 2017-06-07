//
//  StatisticsDataController.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 03.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import Foundation
import CoreData

class StatisticsDataController {
    let managedObjectContext: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        managedObjectContext = moc
    }
    
    convenience init?() {
        
        guard let modelURL = NSBundle.mainBundle().URLForResource("StatisticsModel", withExtension: "momd") else {
            return nil
        }
        
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            return nil
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("Statistics.sqlite")
        
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store.")
        }
        
        self.init(moc: moc)
    }
    
    func getLettersStatistics() -> NSFetchedResultsController {
        let statFetch = NSFetchRequest(entityName: "LetterStatistics")
        statFetch.sortDescriptors = [NSSortDescriptor(key: "letter", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: statFetch, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func updateLetterStatistics(letter: String, questionType: QuestionType, isCorrect: Bool) {
        let fetch = NSFetchRequest(entityName: "LetterStatistics")
        fetch.predicate = NSPredicate(format: "letter == %@", letter)
        fetch.fetchLimit = 1
        
        var fetched: [LetterStatistics]!
        do {
            fetched = try self.managedObjectContext.executeFetchRequest(fetch) as! [LetterStatistics]
        } catch {
            fatalError("fetch letter \(letter) failed")
        }

        let stat = fetched[0]
        switch questionType {
        case .FlagLetter:
            print("Letter [\(letter)] stat: \(stat.correct_letter) of \(stat.asked_letter)")
            if isCorrect {
                stat.correct_letter = Int(stat.correct_letter!) + 1
            }
            stat.asked_letter = Int(stat.asked_letter!) + 1
            
            print("Letter [\(letter)] correct: \(isCorrect), now \(stat.correct_letter) of \(stat.asked_letter)")
            
        case .FlagMemo:
            print("Memo [\(letter)] stat: \(stat.correct_memo) of \(stat.asked_memo)")
            if isCorrect {
                stat.correct_memo = Int(stat.correct_memo!) + 1
            }
            stat.asked_memo = Int(stat.asked_memo!) + 1
            print("Memo [\(letter)] correct: \(isCorrect), now \(stat.correct_memo) of \(stat.asked_memo)")
            
        case .FlagMeaning:
            print("Meaning [\(letter)] correct: \(isCorrect), now \(stat.correct_meaning) of \(stat.asked_meaning)")
            if isCorrect {
                stat.correct_meaning = Int(stat.correct_meaning!) + 1
            }
            stat.asked_meaning = Int(stat.asked_meaning!) + 1
            print("Meaning [\(letter)] correct: \(isCorrect), now \(stat.correct_meaning) of \(stat.asked_meaning)")
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
    
    func createLetterStatisticsIfNeeded() {
        let statFetch = NSFetchRequest(entityName: "LetterStatistics")
        statFetch.fetchLimit = 1
        
        var fetched: [LetterStatistics]!
        do {
            fetched = try self.managedObjectContext.executeFetchRequest(statFetch) as! [LetterStatistics]
        } catch {
            fatalError("Failed to fetch letter statistics")
        }
        
        if fetched != nil && fetched.count > 0 {
            return
        }
        
        for letter in "abcdefghijklmnopqrstuvwxyz".characters {
            let stat = NSEntityDescription.insertNewObjectForEntityForName("LetterStatistics", inManagedObjectContext: self.managedObjectContext) as! LetterStatistics
            stat.reset(String(letter))
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't create default statistics")
        }
    }
    
    func resetLetterStatistics() {
        let statFetch = NSFetchRequest(entityName: "LetterStatistics")
        statFetch.sortDescriptors = [NSSortDescriptor(key: "letter", ascending: true)]
        
        var fetched: [LetterStatistics]!
        do {
            fetched = try self.managedObjectContext.executeFetchRequest(statFetch) as! [LetterStatistics]
        } catch {
            fatalError("fetch failed")
        }
        
        for stat in fetched {
            stat.reset()
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't reset statistics")
        }
    }
}
