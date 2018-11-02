//
//  ViewController.swift
//  Todoey
//
//  Created by Abdul Halim Kasim on 31/10/2018.
//  Copyright © 2018 Abdul Halim Kasim. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
   var itemArray = [Item] ()

   let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        
       
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        
    }
    
    //MARK - Tableview Datasource Methods
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        // Another way of writing the if else statement below
        //cell.accessoryType = item.done  ? .checkmark : .none
        
        
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
             cell.accessoryType = .none  }
        
        
        return cell
    }
    
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        // the other way of writing the if else statement BELOW is
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
       
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
             itemArray[indexPath.row].done = false
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Item
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
             // what willhappen when a user press the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
       
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}


