//
//  MyTableViewController.swift
//  Lab_6
//
//  Created by user238292 on 2/19/24.
//

import UIKit

struct TodoItem: Codable {
    var title: String
}

class MyTableViewController: UITableViewController {

    
    var Items = [TodoItem]()
           
           override func viewDidLoad() {
               super.viewDidLoad()
               loadTodoItems()
           }
           
           // MARK: - Table view data source
           
           override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return Items.count
           }
           
           override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let tablecell = tableView.dequeueReusableCell(withIdentifier: "ToDoList", for: indexPath)
               let Item = Items[indexPath.row]
               tablecell.textLabel?.text = Item.title
               return tablecell
           }
           
           // MARK: - Actions
       
       
    @IBOutlet weak var Insert: UIBarButtonItem!
    
    @IBAction func Insert(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
        /*@IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
            showAddTodoAlert()
           }*/
           
           // MARK: - Private Methods
           
           private func showAlert() {
               let alertController = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)
               
               alertController.addTextField { textField in
                   textField.placeholder = "Enter Task"
               }
               
               let insertAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
                   if let text = alertController.textFields?.first, let text = text.text, !text.isEmpty {
                       let newItem = TodoItem(title: text)
                       self?.Items.append(newItem)
                       self?.saveTodoItems()
                       self?.tableView.reloadData()
                   }
               }
               
               let removeAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               
               alertController.addAction(insertAction)
               alertController.addAction(removeAction)
               
               present(alertController, animated: true, completion: nil)
           }
           
            private func saveTodoItems() {
               // Implement data persistence to save todoItems
               // For example, you can use UserDefaults or Core Data
               // UserDefaults is used in this example for simplicity
               let detail = try? JSONEncoder().encode(Items)
               UserDefaults.standard.set(detail, forKey: "todoItems")
           }
            
           
           private func loadTodoItems() {
               // Load todoItems from data persistence
               if let details = UserDefaults.standard.data(forKey: "todoItems"),
                  let savedTodoItems = try? JSONDecoder().decode([TodoItem].self, from: details) {
                   Items = savedTodoItems
               }
           }
           
           // MARK: - Table view delegate
           
           override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
               if editingStyle == .delete {
                   Items.remove(at: indexPath.row)
                   saveTodoItems()
                   tableView.deleteRows(at: [indexPath], with: .fade)
               }
           }

}
