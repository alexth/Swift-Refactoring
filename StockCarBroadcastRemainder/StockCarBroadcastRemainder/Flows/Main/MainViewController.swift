//
//  MainViewController.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 2/21/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit
import DynamicButton

final class MainViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var seriesButton: DynamicButton!
    @IBOutlet weak var calendarButton: DynamicButton!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var seriesView: SeriesView!
//    @IBOutlet weak var seriesViewTopConstraint: NSLayoutConstraint!
    fileprivate var seriesView: SeriesView!

    fileprivate var currentWeekEventsArray = [Event]()
    fileprivate var futureEventsArray = [Event]()
    fileprivate let cellIdentifier: String = "mainCell"
    fileprivate let eventDetailsSegue = "toEventDetails"
    fileprivate let mainTableViewSectionsCount = 2
    fileprivate let currentWeekEventsSection = 0
    fileprivate let futureEventsSection = 1
    fileprivate let mainTableViewCellHeight: CGFloat = 100.0
    fileprivate let mainTableViewHeaderHeight: CGFloat = 30.0
    fileprivate let mainTableViewFooterHeight: CGFloat = 0.01
    fileprivate let topBarDefaultHeight: CGFloat = 64.0
    fileprivate let topBarExpandedHeight: CGFloat = 150.0
    fileprivate let containerDefaultBottom: CGFloat = -220.0
    fileprivate let containerExpandedBottom: CGFloat = 0.0
    fileprivate var topBarOpened = false

    fileprivate var selectedEvent: Event?

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        seriesButton.style = DynamicButtonStyle.caretDown

        updateEvents()
        super.viewDidLoad()
        setupSeriesView()
        // TODO:
        calendarButton.isHidden = true
//        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.selectedSeriesChanged(_:)), name: NSNotification.Name(rawValue: Notifications.updateSeriesNotification), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.displayEvent(_:)), name: NSNotification.Name(rawValue: Notifications.displayEventData), object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == eventDetailsSegue {
            let edvc = segue.destination as! EventDetailsViewController
            edvc.event = selectedEvent
        }
    }

    func selectedSeriesChanged(notification: Notification) {
        updateEvents()
        let sectionsIndexSet:IndexSet = IndexSet(integersIn: NSMakeRange(0, mainTableView.numberOfSections).toRange()!)
        mainTableView.reloadSections(sectionsIndexSet, with: .automatic)
    }

    func displayEvent(notification: Notification) {
    }

    fileprivate func setupSeriesView() {
//        seriesView = SeriesView(subView: self)
        seriesView = SeriesView(frame: <#T##CGRect#>)
        seriesView.setupDataAndView()

    }

    fileprivate func updateEvents() {
        let databaseManager = DatabaseManager.sharedInstance
        let fetchedCurrentWeekEventsArray = databaseManager.currentWeekEvents()
        if fetchedCurrentWeekEventsArray.isEmpty == true {
            currentWeekEventsArray = []
            futureEventsArray = databaseManager.futureEvents(afterEvent: nil)
        } else {
            currentWeekEventsArray = fetchedCurrentWeekEventsArray 
            let lastEventOfWeek = currentWeekEventsArray.last
            futureEventsArray = databaseManager.futureEvents(afterEvent: lastEventOfWeek)
        }
    }
}

extension MainViewController {
    @IBAction func didPress(menuButton: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            if self.topBarOpened == false {
                self.topBarHeightConstraint.constant = self.topBarExpandedHeight
//                self.seriesViewTopConstraint.constant = self.containerExpandedBottom
                self.seriesView.frame.origin.y = self.containerExpandedBottom
                self.seriesButton.style = DynamicButtonStyle.caretUp
            } else {
                self.topBarHeightConstraint.constant = self.topBarDefaultHeight
//                self.seriesViewTopConstraint.constant = self.containerDefaultBottom
                self.seriesView.frame.origin.y = self.containerDefaultBottom
                self.seriesButton.style = DynamicButtonStyle.caretDown
            }
            self.topBarOpened = !self.topBarOpened
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func didPress(calendarButton: UIButton) {
    }
}

extension MainViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainTableViewSectionsCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == currentWeekEventsSection {
            return currentWeekEventsArray.count
        }
        return futureEventsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainTableViewCell
        if indexPath.section == currentWeekEventsSection {
            let event = currentWeekEventsArray[indexPath.row]
            cell.cellWithEvent(event: event)
            cell.delegate = self
        } else if indexPath.section == futureEventsSection {
            let event = futureEventsArray[indexPath.row]
            cell.cellWithEvent(event: event)
            cell.delegate = self
        }
        return cell
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == currentWeekEventsSection {
            selectedEvent = currentWeekEventsArray[indexPath.row]
        } else if (indexPath as NSIndexPath).section == futureEventsSection {
            selectedEvent = futureEventsArray[indexPath.row]
        }
        performSegue(withIdentifier: eventDetailsSegue, sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainTableViewCellHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("TableViewLabelHeaderView", owner: self, options: nil)?[0] as! TableViewLabelHeaderView
        if section == currentWeekEventsSection {
            if currentWeekEventsArray.count > 0 {
                headerView.textLabel.text = "Upcoming events"
                return headerView
            }
        } else if section == futureEventsSection {
            if futureEventsArray.count > 0 {
                headerView.textLabel.text = "Future events"
                return headerView
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == currentWeekEventsSection, currentWeekEventsArray.count > 0 {
            return mainTableViewHeaderHeight
        } else if section == futureEventsSection, futureEventsArray.count > 0 {
            return mainTableViewHeaderHeight
        }
        return 0.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return mainTableViewFooterHeight
    }
}

extension MainViewController: MainTableViewCellDelegate {
    func displayPicker(forEvent event: Event, cell: MainTableViewCell) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let fifteenMinutesAction = UIAlertAction(title: "15 minutes before", style: .default) { (action) in
            // TODO:
//            let testDate = Date().addingTimeInterval(10.0)
//            LocalNotificationsManager.createLocalNotification(event, fireDate: testDate, completion: {
//                self.updateCellAppearanceAsNotified(event, cell: cell)
//            })
        }
        let thirtyMinutesAction = UIAlertAction(title: "30 minutes before", style: .default) { (action) in }
        let hourAction = UIAlertAction(title: "1 hour before", style: .default) { (action) in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }

        alertController.addAction(fifteenMinutesAction)
        alertController.addAction(thirtyMinutesAction)
        alertController.addAction(hourAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func updateCellAppearanceAsNotified(event: Event, cell: MainTableViewCell) {
        event.isReminderSet = true
        DatabaseManager.sharedInstance.saveContext()
        cell.setReminderStatusButtonImage()
    }
}
