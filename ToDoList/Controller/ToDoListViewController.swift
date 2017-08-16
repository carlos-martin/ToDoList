//
//  ViewController.swift
//  ToDoList
//
//  Created by Carlos Martin on 14/8/17.
//  Copyright © 2017 Carlos Martin. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var session: CurrentUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.session = CurrentUser()
        //self.hideKeyboard()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- TableView
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.session.todoList.count + 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Remaining Tasks"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementViewCell
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        if indexPath.row < self.session.todoList.count {
            cell.textField.text = self.session.todoList[indexPath.row]
        } else {
            cell.textField.placeholder = "Add new entry"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row < self.session.todoList.count {
                self.session.remove(index: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
}

//MARK:- TextField
extension ToDoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let row = textField.tag
        if let entry = textField.text {
            if entry.isEmpty {
                //the entry is empty, we have to remove the cell
                self.session.remove(index: row)
            } else {
                if row >= self.session.todoList.count {
                    //this is a new entry
                    self.session.add(element: entry)
                } else {
                    //this is an old entry
                    self.session.add(element: entry, index: row)
                }
            }
            self.tableView.reloadData()
        }
        self.dismissKeyboard()
        return true
    }

}

//MARK:- Keyboard
extension ToDoListViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ToDoListViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
}
