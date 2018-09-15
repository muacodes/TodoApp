//
//  ViewController.swift
//  TodoApp
//
//  Created by Panuwat on 11/9/2561 BE.
//  Copyright © 2561 Panuwat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNewItemViewControllerDelegate, TodoItemTableViewCellDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    
    func todoItemTableViewCellDidTapCheckboxButton(cell: TodoItemTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            todo.item(at: indexPath.row).toggleIsDone()
            tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]{
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    //MARK: - Todo xxxx
    func addNewItemViewController(controller: AddNewItemViewController, add item: TodoItem) {
        todo.add(item: item)
        if let index = todo.index(for: item) {
            tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addNewItemViewController(controller: AddNewItemViewController, edit item: TodoItem) {
        if let index = todo.index(for: item) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    var todo = Todo()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.totalItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath) as! TodoItemTableViewCell
        let item = todo.item(at: indexPath.row)
        cell.titleLabel?.text = item.title
        cell.checkboxButton.setImage(UIImage(named: item.isDone ? "check": "uncheck"), for: .normal)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openEditItemSegue", sender: todo.item(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {}
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.localDragSession != nil
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todo.move(from: sourceIndexPath.row,to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todo.add(item: TodoItem(title: "test"))
        todo.add(item: TodoItem(title: "test 2", isDone: true))
        todo.add(item: TodoItem(title: "test 3"))
        
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        
        tableView.dropDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openAddItemSegue" {
            if let navController = segue.destination as? UINavigationController,
                let addController = navController.topViewController as? AddNewItemViewController {
                addController.delegate = self
            }
        } else if segue.identifier == "openEditItemSegue" {
            if let navController = segue.destination as? UINavigationController,
                let addController = navController.topViewController as? AddNewItemViewController {
                addController.delegate = self
                addController.todoItem = sender as? TodoItem
            }
        }
    }


}

