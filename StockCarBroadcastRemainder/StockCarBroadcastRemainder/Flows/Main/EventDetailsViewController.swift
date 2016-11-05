//
//  EventDetailsViewController.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/5/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

final class EventDetailsViewController: UIViewController {
    var event: Event!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    let eventTitleCellIdentifier: String = "eventTitleCell"
    let broadcasterCellIdentifier: String = "broadcasterCell"
    let dateCellIdentifier: String = "dateCell"
    let trackInfoCellIdentifier: String = "trackInfoCell"

    let eventTitleCellHeight = 50.0
    let broadcasterCellHeight = 70.0
    let dateCellHeight = 50.0
    let trackInfoCellHeight = 150.0
    
    let eventTitleCellRow = 0
    let broadcasterCellRow = 1
    let dateCellRow = 2
    let trackInfoCellRow = 3
    
    let tableNumberOfSectionsCount = 1
    let tableNumberOfRowsCount = 4
    
    //MARK: -View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = event.title
    }
    
    //MARK: - TableView DataSource
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return tableNumberOfSectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableNumberOfRowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch (indexPath as NSIndexPath).row {
        case eventTitleCellRow:
            cell = tableView.dequeueReusableCell(withIdentifier: eventTitleCellIdentifier, for: indexPath) as! EventTitleTableViewCell
//            cell.setCell
        case broadcasterCellRow:
            cell = tableView.dequeueReusableCell(withIdentifier: broadcasterCellIdentifier, for: indexPath) as! BroadcastersTableViewCell
        case dateCellRow:
            cell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier, for: indexPath) as! TextLabelTableViewCell
        case trackInfoCellRow:
            cell = tableView.dequeueReusableCell(withIdentifier: trackInfoCellIdentifier, for: indexPath) as! TextLabelTableViewCell
        default:
            print("ERROR! Wrong indexPath.row")
        }
        
        return cell!
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
