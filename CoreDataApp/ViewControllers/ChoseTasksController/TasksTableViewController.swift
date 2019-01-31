//
//  TasksTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/29/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {

    private var chosenTasks: Set<Task>?
    private let tasks = Task.fetchAll()
    var complection: (([Task]?) -> (Void))?
    static let reuseIdentifier = "TasksTable"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
    }
    
    @objc func done() {
        guard let chosenTasks = chosenTasks else { return }
        let tasks = Array(chosenTasks)
        complection?(tasks)
        navigationController?.popViewController(animated: true)
    }
    
}


//MARK: Extension DataSource

extension TasksTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = tasks[indexPath.row].taskName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTasks?.insert(tasks[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        chosenTasks?.remove(tasks[indexPath.row])
    }
}
