//
//  SymbolViewController.swift
//  Interco
//
//  Created by Darja Ryazhskikh on 01.06.17.
//  Copyright © 2017 Darja Ryazhskikh. All rights reserved.
//

import UIKit

extension SymbolsListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.symbols.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SymbolCell") as! SymbolTableViewCell
        
        let item = data.symbols[indexPath.row]
        cell.letter.text = String(item.letter).uppercaseString
        cell.memo.text = item.memo
        cell.meaning.text = item.meaning
        cell.flag.image = UIImage(named: item.flag)
        return cell
    }
}