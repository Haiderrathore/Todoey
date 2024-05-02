//
//  ViewController.swift
//  Todoey
//
//  Created by Haider Rathore on 02/05/2024.
//

import UIKit

class TodoListViewController: UITableViewController{

    var itemArray = ["Buy Milk", "Goto UAE", "Get a Job"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let items = defaults.array(forKey: "ToDoItemArray") as? [String]{
            itemArray = items
        }
        // Do any additional setup after loading the view.
    }
    
    //Mark - Table View Data Source Methords
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //Mark - Table View Delegate Methords
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
            
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
        //Mark - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var tempTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
         
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            self.itemArray.append(tempTextField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoItemArray")
            
            self.tableView.reloadData()
            print("Sucess")
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            tempTextField = alertTextField
        }
            
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
