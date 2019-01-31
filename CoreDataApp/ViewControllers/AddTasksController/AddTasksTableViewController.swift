//
//  AddTasksTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/30/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class AddTasksTableViewController: UIInputView, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    
    var tasks: [Task]?
    var selectedTasks: (([Task]?) -> (Void))?
    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var action = [
        UITableViewRowAction(style: .normal, title: "Delete") { [weak self] (_, indexPath) in
        self?.delete(indexPath: indexPath)
        }
    ]
    static let identifier = "AddTasksTableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
    }
    
    @objc func done() {
        selectedTasks?(tasks)
        navigationController?.popViewController(animated: true)
    }
    
    func addFunction() {
        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Task name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Status"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context, weak self] _ in
            guard let context = context else { return }
            guard let self = self else { return }
            let object = Task(context: context)
            object.taskName = alert.textFields?.first?.text
            object.status = alert.textFields?.last?.text
            self.tasks?.append(object)
            self.tableView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func delete(indexPath: IndexPath) {
        self.tasks?.remove(at: indexPath.row)
        self.tableView.reloadData()
    }

}

//MARK: Datasouce and delegete
extension AddTasksTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseIdentifier, for: indexPath) as! TasksTableViewCell
        cell.taskName = tasks?[indexPath.row].taskName
        cell.status = tasks?[indexPath.row].status
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return action
    }
}


