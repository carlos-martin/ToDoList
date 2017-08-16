//
//  Tools.swift
//  ToDoList
//
//  Created by Carlos Martin on 14/08/17.
//  Copyright © 2017 Carlos Martin. All rights reserved.
//

import UIKit

class CurrentUser {
    private      let defaults: UserDefaults = UserDefaults.standard
    private      let key:      String       = "todoList"
    private(set) var todoList: [String]
    
    init() {
        self.todoList = self.defaults.stringArray(forKey: self.key) ?? [String]()
    }
    
    func add(element: String, index: Int?=nil) {
        if index == nil {
            self.todoList.append(element)
        } else {
            self.todoList[index!] = element
        }
        self.save()
    }
    
    func remove(index: Int) {
        if index <= self.todoList.count {
            self.todoList.remove(at: index)
            self.save()
        }
    }
    
    private func save () {
        UserDefaults.standard.set(self.todoList, forKey: self.key)
    }
    
}
