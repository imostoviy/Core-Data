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


    class func loadFromXib() -> CustomAddTasksUIInputView {
        let nib = UINib(nibName: "CustomAddTasksUIInputView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! CustomAddTasksUIInputView
        return view
    }

    //MARK: Properties

    private var tasks: [Task]?
    var selectedTasks: (([Task]?) -> (Void))?
    var employee: String?
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
        self.endEditing(true)
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
        tasks?.append(task)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let task = fetchResultsController.fetchedObjects?[indexPath.row] else { return }
        if let index = tasks?.firstIndex(of: task) {
            tasks?.remove(at: index)
        }
    }
}
