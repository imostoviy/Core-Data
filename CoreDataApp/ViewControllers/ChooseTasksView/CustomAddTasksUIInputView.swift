//
//  CustomAddTasksUIInputViewViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 1/31/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class CustomAddTasksUIInputView: UIInputView {

    //MARK: Outlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let cell = UINib(nibName: "TasksTableViewCell", bundle: nil)
            tableView.register(cell, forCellReuseIdentifier: TasksTableViewCell.reuseIdentifier)
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var doneButton: UIButton! {
        didSet {
            doneButton.addTarget(self, action: #selector(self.done), for: .touchUpInside)
        }
    }

    //MARK: Load
    
    class func loadFromXib() -> CustomAddTasksUIInputView {
        let nib = UINib(nibName: "CustomAddTasksUIInputView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! CustomAddTasksUIInputView
        return view
    }

    //MARK: Properties

    private var tasks: [Task]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.convertToString()
                self.selectRows()
            }
        }
    }
    var selectedTasks: (([Task]?) -> (Void))?
    var tasksNames: ((String?) -> ())?
    static var alert: UIAlertController?
    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var fetchResultsController: NSFetchedResultsController<Task> = {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]
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

    //MARK: actions for tableView

    @objc private func done() {
        selectedTasks?(tasks)
        CustomAddTasksUIInputView.alert?.view.endEditing(true)
    }
    
    //MARK: publick set for tasks
    
    public func setTasks(tasks: [Task]?) {
        self.tasks = tasks
    }
    
    //MARK: Converting tasks names to one string and calling clousure
    private func convertToString() {
        guard let tasks = tasks else { return }
        var names: [String?] = []
        for task in tasks {
            names.append(task.taskName)
        }
        var namesToPass: String = ""
        for name in names {
            if name == nil {
                continue
            } else {
                namesToPass += name! + "; "
            }
        }
        tasksNames?(namesToPass)
    }
    
    //MARK: Select row for tasks
    
    private func selectRows() {
        guard let tasks = tasks else { return }
        guard let allTasks = fetchResultsController.fetchedObjects else { return }
        for task in tasks {
            if let index = allTasks.firstIndex(of: task) {
                let indexPath = IndexPath(row: index, section: 0)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            }
        }
    }
    
}

//MARK: Extension NSFetchedResultsControllerDelegate
extension CustomAddTasksUIInputView: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

//MARK TableViewDataSource and Delegate
extension CustomAddTasksUIInputView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseIdentifier, for: indexPath) as! TasksTableViewCell
        cell.taskNameLabel?.text = fetchResultsController.fetchedObjects?[indexPath.row].taskName
        cell.statusLabel?.text = fetchResultsController.fetchedObjects?[indexPath.row].status
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = fetchResultsController.fetchedObjects?[indexPath.row] else { return }
        guard let _ = tasks?.firstIndex(of: task) else {
            tasks?.append(task)
            convertToString()
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let task = fetchResultsController.fetchedObjects?[indexPath.row] else { return }
        if let index = tasks?.firstIndex(of: task) {
            tasks?.remove(at: index)
            convertToString()
        }
    }
}
