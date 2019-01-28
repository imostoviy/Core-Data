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
    private lazy var context: NSManagedObjectContext = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var fetchResultsController: NSFetchedResultsController<Task> = {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "tasks.taskName", ascending: true)]
        let controller = NSFetchedResultsController<Task>(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        //controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            debugPrint(error)
        }
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addFunction() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        
    }
}
