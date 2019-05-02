//
//  ViewController.swift
//  Todoey
//
//  Created by Grégory DINOV on 30/04/2019.
//  Copyright © 2019 Grégory DINOV. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
//    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogogon"]
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "FindMike"
        itemArray.append(newItem)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = String(item.title)
        
        // SWIFT TERNARY OPERATOR
        // value = condition ? valueIfTrue : ValueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        // Nous avons créer au dessus un TERNARY à partir du if else statement en dessous.
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // Au dessus équivaut à écrire le if else statment
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
    }
    
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on ou UIAlert
            
            let newItem = Item()
            newItem.title = textfield.text!
            
            self.itemArray.append(newItem)
//            self.itemArray.append(textfield.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
    
            self.tableView.reloadData()
            
//            print(textfield.text!)
            print("Success!")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

