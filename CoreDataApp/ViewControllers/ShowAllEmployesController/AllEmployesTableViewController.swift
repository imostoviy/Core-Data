//
//  AllEmployesTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 2/7/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import CoreData

class AllEmployesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: properties
    
    private lazy var context = CoreDataStack.shared.persistantContainer.viewContext
    private lazy var developersFetchedResultsController: NSFetchedResultsController<Developer> = {
        let fetchRequest: NSFetchRequest<Developer> = Developer.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<Developer>(
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
    
    private lazy var  designersFetchedResultsController: NSFetchedResultsController<Designer> = {
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
    
    private lazy var managersFetchedResultsController: NSFetchedResultsController<Manager> = {
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
}

//MARK: extension FetchedResultsControllerDelegate

extension AllEmployesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

//MARK: TableViewDelegate and dataSource

extension AllEmployesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return developersFetchedResultsController.fetchedObjects?.count ?? 0
        case 1: return designersFetchedResultsController.fetchedObjects?.count ?? 0
        default: return managersFetchedResultsController.fetchedObjects?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Employee", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let object = developersFetchedResultsController.fetchedObjects?[indexPath.row]
            cell.textLabel?.text = object?.fullName
            cell.detailTextLabel?.text = "developer"
        case 1:
            let object = designersFetchedResultsController.fetchedObjects?[indexPath.row]
            cell.textLabel?.text = object?.fullName
            cell.detailTextLabel?.text = "designer"
        default:
            let object = managersFetchedResultsController.fetchedObjects?[indexPath.row]
            cell.textLabel?.text = object?.fullName
            cell.detailTextLabel?.text = "manager"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let highStatusTasksController = storyBoard.instantiateViewController(withIdentifier: HighStatusTasksTableViewController.reuseIdentifier) as! HighStatusTasksTableViewController
        switch indexPath.section {
        case 0:
            highStatusTasksController.developer = developersFetchedResultsController.fetchedObjects?[indexPath.row]
        case 1:
            highStatusTasksController.designer = designersFetchedResultsController.fetchedObjects?[indexPath.row]
        default:
            highStatusTasksController.manager = managersFetchedResultsController.fetchedObjects?[indexPath.row]
        }
        
        navigationController?.pushViewController(highStatusTasksController, animated: true)
    }
}
