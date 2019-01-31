//
//  ManagerTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/30/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class ManagerTableViewController: ParentTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Private properties
    
    private var selectedTasks: [Task]?
    var alert: UIAlertController?
    let cell = UINib(nibName: "DevelopersTableViewCell", bundle: nil)
    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var fetchedResultsController: NSFetchedResultsController<Manager> = {
        let fetchRequest: NSFetchRequest<Manager> = Manager.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<Manager>(
            fetchRequest: fetchRequest,
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
    
    private lazy var editActions = [
        UITableViewRowAction(style: .normal, title: "Edit", handler: { [weak self] (_, indexPath) in
            self?.editAction(indexPath: indexPath)
        }),
        UITableViewRowAction(style: .normal, title: "Delete", handler: { [weak self] (_, indexPath) in
            self?.deleteAction(indexPath: indexPath)
        })
    ]
    
    //MARK: Function for adding values to Developer
    
    override func addFunction() {
        alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        guard let alert = alert else { return }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surname"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "XP(Months)"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Chose task"
            textField.addTarget(self, action: #selector(self.getChosenTasks), for: .touchUpInside)
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            [weak context,
            weak self] _ in
            guard let context = context else { return }
            guard let tasks = self?.selectedTasks else { return }
            
            let object = Manager(context: context)
            object.name = alert.textFields?[0].text
            object.surname = alert.textFields?[1].text
            object.xp = Int32(alert.textFields?[2].text ?? "") ?? 0
            for task in tasks {
                object.addToTasks(task)
            }
            
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Function for handling data from tableviewController
    @objc private func getChosenTasks(complection: ((UITextField) -> (Void))) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let taskTableViewController = storyboard.instantiateViewController(withIdentifier: TasksTableViewController.reuseIdentifier) as! TasksTableViewController
        taskTableViewController.title = "Chose tasks"
        navigationController?.pushViewController(taskTableViewController, animated: true)
        taskTableViewController.complection = {(tasks) in
            guard let tasks = tasks else { return }
            self.selectedTasks = tasks
            guard let alert = self.alert else {
                return
            }
            var tasksString = ""
            for task in tasks {
                tasksString += (task.taskName ?? "") + "; "
            }
            alert.textFields?[3].text = tasksString
        }
    }
    
    //MARK: Functions for rows in table view
    
    private func editAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        guard let alert = alert else { return }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = object.name
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surname"
            textField.text = object.surname
        }
        alert.addTextField { (textField) in
            textField.placeholder = "XP(Months)"
            textField.text = String(object.xp)
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Chose tasks"
            textField.addTarget(self, action: #selector(self.getChosenTasks), for: .touchUpInside)
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            [weak context,
            weak self] _ in
            guard let context = context else { return }
            guard let tasks = self?.selectedTasks else { return }
            
            let object = Manager(context: context)
            object.name = alert.textFields?[0].text
            object.surname = alert.textFields?[1].text
            object.xp = Int32(alert.textFields?[2].text ?? "") ?? 0
            for task in tasks {
                object.addToTasks(task)
            }
            
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //delete option
    private func deleteAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        context.delete(object)
        do {
            try context.save()
        } catch { debugPrint(error) }
    }
}

//MARK: Extension FethcedResultsControllerDelegate

extension ManagerTableViewController : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

//MARK: Extension TableView delegate and data source

extension ManagerTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManagerTableViewCell.reuseIdentifier, for: indexPath) as! ManagerTableViewCell
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return cell}
        cell.fullName = object.fullName
        cell.experience = String(object.xp)
        var tasksString = ""
        guard let tasks = object.tasks else { return cell }
        for task in tasks {
            tasksString += ((task as! Task).taskName ?? "") + "; "
        }
        cell.tasksLabel.text = tasksString
        return cell
    }
}
