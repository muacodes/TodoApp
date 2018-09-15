//
//  AddNewItemViewController.swift
//  TodoApp
//
//  Created by Panuwat on 11/9/2561 BE.
//  Copyright © 2561 Panuwat. All rights reserved.
//

import UIKit

protocol AddNewItemViewControllerDelegate:class {
    func addNewItemViewController(controller: AddNewItemViewController, add item: TodoItem)
    func addNewItemViewController(controller: AddNewItemViewController, edit item: TodoItem)
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController)
}

class AddNewItemViewController: UIViewController {
    
    weak var delegate: AddNewItemViewControllerDelegate?
    var todoItem: TodoItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    @IBAction func doneButtonDidTap(_ sender:UIBarButtonItem) {
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        if let todoItem = todoItem {
            todoItem.title = text
            todoItem.isDone = isDoneSwitch.isOn
            delegate?.addNewItemViewController(controller: self, edit: todoItem)
        } else {
            let item = TodoItem(title: text, isDone: isDoneSwitch.isOn)
            delegate?.addNewItemViewController(controller: self, add: item)
        }
        
    }
    
    @IBAction func cancelButtonDidTap() {
        delegate?.addNewItemViewControllerDidCancel(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let todoItem = todoItem {
            title = "Edit Item"
            textField.text = todoItem.title
            isDoneSwitch.isOn = todoItem.isDone
        } else {
            title = "Add new item"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }

}
