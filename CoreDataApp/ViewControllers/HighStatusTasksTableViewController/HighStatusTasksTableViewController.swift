//
//  HighStatusTasksTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 2/7/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class HighStatusTasksTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TasksTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TasksTableViewCell.reuseIdentifier)
    }
    
    //MARK: Properties
    static let reuseIdentifier = "HighStatusTasksController"
    var manager: Manager? {
        didSet {
            guard let manager = manager else { return }
            if manager.tasks?.count == 0 { return }
            var tasksWithHighStatus: [Task] = []
            for task in conertToArray(mustBeConverted: manager.tasks) {
                if task.status == "High" {
                    tasksWithHighStatus.append(task)
                }
            }
            self.tasksWithHighStatus = tasksWithHighStatus
        }
    }
    var developer: Developer? {
        didSet {
            guard let developer = developer else { return }
            if developer.mainTask?.count == 0 { return }
            var tasksWithHighStatus: [Task] = []
            for task in conertToArray(mustBeConverted: developer.mainTask) {
                if task.status == "High" {
                    tasksWithHighStatus.append(task)
                }
            }
            self.tasksWithHighStatus = tasksWithHighStatus
        }
    }
    
    var designer: Designer? {
        didSet {
            guard let designer = designer else { return }
            if designer.mainTask?.count == 0 { return }
            var tasksWithHighStatus: [Task] = []
            for task in conertToArray(mustBeConverted: designer.mainTask) {
                if task.status == "High" {
                    tasksWithHighStatus.append(task)
                }
            }
            self.tasksWithHighStatus = tasksWithHighStatus
        }
    }
    private var tasksWithHighStatus: [Task]?
    
    //MARK: convert NSSet<Task> into Array[Task]
    
    private func conertToArray(mustBeConverted: NSSet?) -> [Task] {
        guard let nsset = mustBeConverted else { return []}
        var arrayToPassBack: [Task] = []
        for task in nsset {
            arrayToPassBack.append(task as! Task)
        }
        return arrayToPassBack
    }
    
}

//MARK: TableViewDataSource and delegate

extension HighStatusTasksTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksWithHighStatus?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseIdentifier, for: indexPath) as! TasksTableViewCell
        cell.taskNameLabel.text = tasksWithHighStatus?[indexPath.row].taskName
        cell.statusLabel.text = tasksWithHighStatus?[indexPath.row].status
        return cell
    }
}
