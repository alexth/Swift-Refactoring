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
    @IBOutlet weak var goNextButton: UIButton!
    @IBOutlet weak var seriesCountLabel: UILabel!

    fileprivate let seriesCellIdentifier: String = "serieCell"
    fileprivate let numberOfSections: Int = 1
    fileprivate let seriesCellHeight: CGFloat = 55.0
    fileprivate let headerFooterHeight: CGFloat = 0.01
    fileprivate let databaseManager = DatabaseManager.sharedInstance
    fileprivate var seriesArray = [Serie]()

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        fetchSeries()
    }
}

extension SeriesViewController {
    @IBAction func didPress(goNextButton: UIButton) {
        let mainStoryboard =  UIStoryboard.init(name: "Main", bundle: nil)
        let mnc = mainStoryboard.instantiateViewController(withIdentifier : "mainNavigationController") as! UINavigationController
        if let mvc = mnc.viewControllers.first {
            navigationController?.pushViewController(mvc, animated: true)
        }
    }
}

extension SeriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: seriesCellIdentifier, for: indexPath) as! SerieCell
        let serie = seriesArray[indexPath.row]
        cell.setCell(serie: serie)
        return cell
    }
}

extension SeriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let serie = seriesArray[indexPath.row]
        if serie.isSelected == true {
            serie.isSelected = false
        } else {
            serie.isSelected = true
        }
        let cell = tableView.cellForRow(at: indexPath) as! SerieCell
        cell.setCell(serie: serie)

        databaseManager.saveContext()
        //TODO:
//        NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.updateSeriesNotification), object: nil)

        fetchSeries()

        let sectionsIndexSet: IndexSet = IndexSet(integersIn: NSMakeRange(0, tableView.numberOfSections).toRange()!)
        tableView.reloadSections(sectionsIndexSet, with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return seriesCellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerFooterHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return headerFooterHeight
    }
}

extension SeriesViewController {
    fileprivate func fetchSeries() {
        seriesArray = databaseManager.series()
        let selectedSeriesCount = countSelectedSeries()
        if selectedSeriesCount == 0 {
//            goNextButton.titleLabel?.text = "Select series you want follow up"
            seriesCountLabel.text = "Select series you want follow up"
            goNextButton.isEnabled = false
        } else {
//            goNextButton.titleLabel?.text = "You are following \(selectedSeriesCount) from \(seriesArray.count) available series"
            seriesCountLabel.text = "You are following \(selectedSeriesCount) from \(seriesArray.count) available series"
            goNextButton.isEnabled = true
        }
    }

    fileprivate func countSelectedSeries() -> Int {
        var selectedSeriesCount = 0
        for serie in seriesArray {
            let iteratedSerie = serie
            if iteratedSerie.isSelected == true {
                selectedSeriesCount += 1
            }
        }
        return selectedSeriesCount
    }
}
