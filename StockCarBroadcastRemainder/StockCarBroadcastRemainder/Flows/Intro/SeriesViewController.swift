//
//  SeriesViewController.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/5/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

final class SeriesViewController: UIViewController {
    @IBOutlet weak var seriesTableView: UITableView!
    @IBOutlet weak var tipLabel: UILabel!

    var seriesArray = [AnyObject]()
    let seriesCellIdentifier: String = "serieCell"
    let seriesCellHeight: CGFloat = 55.0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        fetchSeries()
    }
}

extension SeriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: seriesCellIdentifier, for: indexPath) as! SerieCell
        let serie = seriesArray[(indexPath as NSIndexPath).row] as! Serie
        cell.setCell(serie: serie)

        return cell
    }
}

extension SeriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Serie = seriesArray[(indexPath as NSIndexPath).row] as! Serie
        if Serie.isSelected == true {
            Serie.isSelected = false
        } else {
            Serie.isSelected = true
        }
        let cell = tableView.cellForRow(at: indexPath) as! SerieCell
        cell.setCell(serie: Serie)

        DatabaseManager.sharedInstance.saveContext()
        NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.updateSeriesNotification), object: nil)

        fetchSeries()

        let sectionsIndexSet:IndexSet = IndexSet(integersIn: NSMakeRange(0, tableView.numberOfSections).toRange()!)
        tableView.reloadSections(sectionsIndexSet, with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return seriesCellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}

extension SeriesViewController {
    fileprivate func fetchSeries() {
//        seriesArray = DatabaseManager.sharedInstance.getSeries() as! [Serie]
//
//        let selectedSeriesCount: Int = countSelectedSeries()
//        if selectedSeriesCount  == 0 {
//            tipLabel.text! = "Select series you want follow up"
//        } else {
//            tipLabel.text! = "You are following \(selectedSeriesCount) from \(seriesArray.count) available series"
//        }
    }

    fileprivate func countSelectedSeries() -> Int {
        var selectedSeriesCount: Int = 0
        for serie in seriesArray {
            let iteratedSerie = serie as! Serie
            if iteratedSerie.isSelected == true {
                selectedSeriesCount += 1
            }
        }

        return selectedSeriesCount
    }
}
