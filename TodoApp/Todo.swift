//
//  Todo.swift
//  TodoApp
//
//  Created by Panuwat on 11/9/2561 BE.
//  Copyright © 2561 Panuwat. All rights reserved.
//

import Foundation

class Todo {
    private var items = [TodoItem]()
    
    var totalItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> TodoItem {
        return items[index]
    }
    
    func index(for item: TodoItem) -> Int? {
        
        return items.index { (todoItem) -> Bool in
            return todoItem === item
        }
        
        // same as
        //        return items.index { (todoItem) -> Bool in
        //            todoItem === item
        //        }
        
        // same as
        //return items.index { $0 === item }
    }
    
    func add(item: TodoItem){
        items.insert(item, at: 0)
    }
    
    func remove(at index: Int){
        items.remove(at: index)
    }
    
    func move(from sourceIndex: Int, to destinationIndex: Int) {
        let item = items.remove(at: sourceIndex);
        items.insert(item, at: destinationIndex)
    }
}

class TodoItem {
    var title:String
    var isDone: Bool
    
//    convenience init (title: String) {
//        self.title = title
//    }
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
    
    func toggleIsDone() {
        isDone = !isDone
    }
    
}
