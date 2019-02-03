//
//  TasksTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/27/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class ProjectsTableViewController: ParentTableViewController {
    
    //MARK: Private properties
    
    @IBOutlet weak var addButton: UIButton!
    private lazy var action = [UITableViewRowAction(style: .normal, title: "Delete", handler: { [weak self] (_, indexPath) in
        self?.deleteAction(indexPath: indexPath)
    })]
    private lazy var context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var fetchResultsController: NSFetchedResultsController<Project> = {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "deadLine", ascending: true)]
        let controller = NSFetchedResultsController<Project>(
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.addTarget(self, action: #selector(self.addFunction), for: .touchUpInside)
        addButton.titleLabel?.text = "+"
    }
    
    override func addFunction() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "New project"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter daedline"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context] _ in
            guard let context = context else { return }
            //guard let tasks = self.tasks else { return }
            
            let object = Project(context: context)
            object.projectName = alert.textFields?.first?.text
            object.deadLine = alert.textFields?.last?.text
            
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteAction(indexPath: IndexPath) {
        guard let object = fetchResultsController.fetchedObjects?[indexPath.row] else { return }
        context.delete(object)
        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    }
}

//MARK: Extension NSFetchedResultsControllerDelegate
extension ProjectsTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

//MARK: Extention TableViewDataSource, TableViewDatasource
extension ProjectsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ProjectsCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = fetchResultsController.fetchedObjects?[indexPath.row].projectName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addTasksController = storyboard.instantiateViewController(withIdentifier: AddTasksTableViewController.identifier) as! AddTasksTableViewController
        addTasksController.tasks = {(tasks) in
            guard let tasks = tasks else { return }
            if tasks.count == 0 { return }
            for task in tasks {
                self.fetchResultsController.fetchedObjects?[indexPath.row].addToTasks(task)
            }
            DispatchQueue.main.async {
                do {
                    try self.context.save()
                } catch {
                    debugPrint(error)
                }
            }
        }
        
        guard let project = fetchResultsController.fetchedObjects?[indexPath.row] else {
            navigationController?.pushViewController(addTasksController, animated: true)
            return
        }
        addTasksController.project = project
        addTasksController.navigationItem.title = project.deadLine
        navigationController?.pushViewController(addTasksController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self.action
    }
}
