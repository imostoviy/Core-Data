//
//  AddTasksTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/30/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class AddTasksTableViewController: ParentTableViewController {

    //MARK: Properties
    
    var project: Project!
    var tasks: (([Task]?) -> (Void))?
    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var action = [
        UITableViewRowAction(style: .normal, title: "Delete") { [weak self] (_, indexPath) in
        self?.delete(indexPath: indexPath)
        }
    ]
    private lazy var fetchResultsController: NSFetchedResultsController<Task> = {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]
        request.predicate = NSPredicate(format: "project == %@", project)
        let controller = NSFetchedResultsController<Task>(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            debugPrint(error)
        }
        return controller
    }()
    
    static let identifier = "AddTasksTableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        let cell = UINib(nibName: "TasksTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: TasksTableViewCell.reuseIdentifier)
    }
    
    @objc func done() {
        navigationController?.popViewController(animated: true)
        tasks?(fetchResultsController.fetchedObjects)
    }
    
    override func addFunction() {
        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Task name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Status"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context] _ in
            guard let context = context else { return }
            let object = Task(context: context)
            object.taskName = alert.textFields?.first?.text
            object.status = alert.textFields?.last?.text
            object.project = self.project
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func delete(indexPath: IndexPath) {
        guard let object = fetchResultsController.fetchedObjects?[indexPath.row] else { return }
        context.delete(object)
        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    }

}

//MARK: Datasouce and delegete
extension AddTasksTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseIdentifier, for: indexPath) as! TasksTableViewCell
        cell.taskNameLabel.text = fetchResultsController.fetchedObjects?[indexPath.row].taskName
        cell.statusLabel.text = fetchResultsController.fetchedObjects?[indexPath.row].status
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return action
    }
}

//MARK: Extension NSFetchedResultsControllerDelegate
extension AddTasksTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
