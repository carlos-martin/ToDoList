//
//  ViewController.swift
//  ToDoList
//
//  Created by Carlos Martin on 14/8/17.
//  Copyright © 2017 Carlos Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var todoList: [String] = ["Add persistent storage", "Remove elements from the list"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hideKeyboard()
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count + 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "To do list:"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
        if indexPath.row < self.todoList.count {
            cell.textField.text = self.todoList[indexPath.row]
        } else {
            cell.textField.placeholder = "Add new entry"
        }
        return cell
    }
    
}

//MARK:- TextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let row = textField.tag
        if let entry = textField.text {
            if row >= self.todoList.count {
                //this is a new entry
                self.todoList.append(entry)
            } else {
                //this is an old entry
                self.todoList[row] = entry
            }
            self.tableView.reloadData()
        }
        self.dismissKeyboard()
        return true
    }

}

//MARK:- Keyboard
extension ViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
}
