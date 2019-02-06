//
//  DesidnerTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/30/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class DesignerTableViewController: ParentTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addFunction))
        tableView.register(cell, forCellReuseIdentifier: DesignersTableViewCell.reuseIdentifier)
    }
    
    //MARK: Private properties
    
    private var selectedTasks: [Task]? = []
    var alert: UIAlertController?
    let cell = UINib(nibName: "DesignersTableViewCell", bundle: nil)
    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var fetchedResultsController: NSFetchedResultsController<Designer> = {
        let fetchRequest: NSFetchRequest<Designer> = Designer.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<Designer>(
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
        var selectedBoss: Manager?
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
            let inputView = CustomAddTasksUIInputView.loadFromXib()
            CustomAddTasksUIInputView.alert = self.alert
            textField.inputView = inputView
            inputView.selectedTasks = { (tasks) in
                self.selectedTasks = tasks
                guard let tasks = tasks else { return }
                switch tasks.count {
                case 0:
                    textField.text = nil
                    textField.placeholder = "chose tasks"
                case 1: textField.text = tasks[0].taskName ?? ""
                default: textField.text = tasks[0].taskName ?? "" + "..."
                }
            }
            
        }
        alert.addTextField { (textFied) in
            textFied.placeholder = "Chose boss"
            let inputView = UIPickerForBoss()
            inputView.delegate = inputView
            inputView.dataSource = inputView
            inputView.listOfObjects = Manager.fetchAll()
            UIPickerForBoss.alert = alert
            textFied.inputView = inputView
            textFied.inputAccessoryView = inputView.createToolBar()
            inputView.selectedManager = {(boss) in
                guard let boss = boss else { return }
                textFied.text = boss.fullName
                selectedBoss = boss
            }
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            [weak context,
            weak selectedBoss,
            weak self] _ in
            guard let context = context else { return }
            guard let self = self else { return }
            
            let object =  Designer(context: context)
            object.name = alert.textFields?[0].text
            object.surname = alert.textFields?[1].text
            object.xp = Int32(alert.textFields?[2].text ?? "") ?? 0
            object.boss = selectedBoss
            if self.selectedTasks?.count != 0 {
                guard let tasks = self.selectedTasks else {
                    try? context.save()
                    return
                }
                for task in tasks {
                    object.addToMainTask(task)
                }
            }
            
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Functions for rows in table view
    
    private func editAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        guard let alert = alert else { return }
        var selectedBoss: Manager?
        
        alert.addTextField { (textField) in
            textField.text = object.name
        }
        alert.addTextField { (textField) in
            textField.text = object.surname
        }
        alert.addTextField { (textField) in
            textField.text = String(object.xp)
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            let inputView = CustomAddTasksUIInputView.loadFromXib()
            CustomAddTasksUIInputView.alert = alert
            textField.inputView = inputView
            inputView.selectedTasks = { (tasks) in
                self.selectedTasks = tasks
            }
            
        }
        alert.addTextField { (textFied) in
            textFied.placeholder = "Chose boss"
            textFied.text = object.boss?.fullName
            let inputView = UIPickerForBoss()
            UIPickerForBoss.alert = alert
            inputView.listOfObjects = Manager.fetchAll()
            textFied.inputView = inputView
            textFied.inputAccessoryView = inputView.createToolBar()
            inputView.selectedManager = {(boss) in
                guard let boss = boss else { return }
                textFied.text = boss.fullName
                selectedBoss = boss
            }
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            [weak context,
            weak selectedBoss,
            weak self] _ in
            guard let context = context else { return }
            guard let self = self else { return }
            
            let object = Developer(context: context)
            object.name = alert.textFields?[0].text
            object.surname = alert.textFields?[1].text
            object.xp = Int32(alert.textFields?[2].text ?? "") ?? 0
            object.boss = selectedBoss
            if self.selectedTasks?.count != 0 {
                guard let tasks = self.selectedTasks else {
                    try? context.save()
                    return
                }
                for task in tasks {
                    object.addToMainTask(task)
                }
            }
            do {
                try context.save()
            } catch {
                debugPrint(error)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
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

extension DesignerTableViewController : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

//MARK: Extension TableView delegate and data source

extension DesignerTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DesignersTableViewCell.reuseIdentifier, for: indexPath) as! DesignersTableViewCell
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return cell}
        cell.fullNameLabel.text = object.fullName
        cell.experienceLabel.text = String(object.xp)
        cell.bossLabel.text = object.boss?.fullName
        var tasksString = ""
        guard let tasks = object.mainTask else { return cell }
        for task in tasks {
            tasksString += ((task as! Task).taskName ?? "") + "; "
        }
        cell.mainTaskLabel.text = tasksString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions
    }
}
