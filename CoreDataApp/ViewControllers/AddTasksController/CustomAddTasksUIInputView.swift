////
////  CustomAddTasksUIInputViewViewController.swift
////  CoreDataApp
////
////  Created by Мостовий Ігор on 1/31/19.
////  Copyright © 2019 Мостовий Ігор. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class CustomAddTasksUIInputView: UIInputView {
//
//    //MARK: Outlets
//
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            tableView.delegate = self
//            tableView.dataSource = self
//        }
//    }
//    @IBOutlet weak var doneButton: UIButton! {
//        didSet {
//            doneButton.addTarget(self, action: #selector(self.done), for: .touchUpInside)
//        }
//    }
//    @IBOutlet weak var addButton: UIButton! {
//        didSet {
//            addButton.addTarget(self, action: #selector(self.addFunction), for: .touchUpInside)
//        }
//    }
//
//    class func loadFromXib() -> CustomAddTasksUIInputView {
//        let nib = UINib(nibName: "CustomAddTasksUIInputView", bundle: nil)
//        let view = nib.instantiate(withOwner: nil, options: nil).first as! CustomAddTasksUIInputView
//        return view
//    }
//
//    //MARK: Properties
//
//    var tasks: [Task]?
//    var selectedTasks: (([Task]?) -> (Void))?
//    var projectName: String?
//    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
//    private lazy var action = [
//        UITableViewRowAction(style: .normal, title: "Delete") { [weak self] (_, indexPath) in
//            self?.delete(indexPath: indexPath)
//        }
//    ]
//    private lazy var fetchResultsController: NSFetchedResultsController<Task> = {
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]
//        let controller = NSFetchedResultsController<Task>(
//            fetchRequest: request,
//            managedObjectContext: context,
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//        controller.delegate = self
//
//        do {
//            try controller.performFetch()
//        } catch {
//            debugPrint(error)
//        }
//        return controller
//    }()
//
//    //MARK: actions for tableView
//
//
//    private func delete(indexPath: IndexPath) {
//        self.tasks?.remove(at: indexPath.row)
//        self.tableView.reloadData()
//    }
//
//    @objc func done() {
//        selectedTasks?(tasks)
//        superview?.endEditing(true)
//    }
//
//    @objc func addFunction() {
//        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.placeholder = "Task name"
//        }
//        alert.addTextField { (textField) in
//            textField.placeholder = "Status"
//        }
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context, weak self] _ in
//            guard let context = context else { return }
//            guard let self = self else { return }
//            let object = Task(context: context)
//            object.taskName = alert.textFields?.first?.text
//            object.status = alert.textFields?.last?.text
//            self.tasks?.append(object)
//            self.tableView.reloadData()
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//}
//
////MARK: Extension NSFetchedResultsControllerDelegate
//extension CustomAddTasksUIInputView: NSFetchedResultsControllerDelegate {
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.reloadData()
//    }
//}
