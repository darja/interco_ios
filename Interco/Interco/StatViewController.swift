//
//  StatViewController.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 07.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import UIKit
import CoreData

class StatViewController: UIViewController, UITableViewDataSource {
    var fetchedStatController: NSFetchedResultsController!
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStatistics()
    }
    
    override func viewWillAppear(animated: Bool) {
        updateStatistics()
        table.reloadData()
    }
    
    @IBAction func onClearClick(sender: AnyObject) {
        let dataController = StatisticsDataController()
        dataController?.resetLetterStatistics()
        updateStatistics()
        table.reloadData()
    }
    
    func updateStatistics() {
        let dataController = StatisticsDataController()
        fetchedStatController = dataController!.getLettersStatistics()
        do {
            try self.fetchedStatController.performFetch()
        } catch {
            fatalError("stat fetch failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedStatController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedStatController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StatCell") as! StatTableViewCell
        
        let item = fetchedStatController.objectAtIndexPath(indexPath) as! LetterStatistics
        
        cell.letter.text = item.letter!.uppercaseString
        cell.stat.text =
            "Letter: \(item.correct_letter!) correct (of \(item.asked_letter!))\n" +
            "Memo: \(item.correct_memo!) correct (of \(item.asked_memo!))\n" +
            "Meaning: \(item.correct_meaning!) correct (of \(item.asked_meaning!))"
        return cell
    }

}
