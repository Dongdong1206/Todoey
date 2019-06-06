//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Meng Dong on 2019/06/05.
//  Copyright © 2019 Dong. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let reaml = try! Realm()

    var categories: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "NO Categories Added Yet"
        
        return cell
        
    }
    
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPatch = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPatch.row]
        }
    }
    
    
    //Data Manipulation Methods
    func save(category: Category){
        do {
            try reaml.write {
                reaml.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){

        categories = reaml.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will hapeen when user clicked Add button on our UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}
