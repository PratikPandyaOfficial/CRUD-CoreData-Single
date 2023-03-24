//
//  ViewController.swift
//  CRUD
//
//  Created by Pratik Pandya on 25/03/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tbl: UITableView!
    
    var items:[Person]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchPeople()
    }
    
    func fetchPeople(){
        do {
            
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            //Filter on Name for search
            //let pred = NSPredicate(format: "name CONTAINS %@", "Test")
            //request.predicate = pred
            
            //Sort data in ascending order
            //let sort = NSSortDescriptor(key: "name", ascending: true)
            //request.sortDescriptors = [sort]
            
            
            self.items = try context.fetch(request)
            //self.items = try context.fetch(Person.fetchRequest()) // for all data
            DispatchQueue.main.async {
                self.tbl.reloadData()
            }
        }
        catch let error{
            print(error)
        }
    }
    
    @IBAction func addPerson(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Person", message: "What's the name?", preferredStyle: .alert)
        
        alert.addTextField()
        
        let submit = UIAlertAction(title: "Add", style: .default){ (action) in
            let textField = alert.textFields![0]
            
            let newPerson = Person(context: self.context)
            newPerson.name = textField.text
            newPerson.age = 20
            
            do{
                try self.context.save()
            }
            catch let error{
                print(error)
            }
            
            self.fetchPeople()
        }
        
        alert.addAction(submit)
        
        self.present(alert, animated: true)
        
    }
    

}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell") as? tblCell else { return UITableViewCell() }
        
        cell.lblName.text = self.items?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person =  self.items![indexPath.row]
        
        let alert = UIAlertController(title: "Rename Person", message: "What's the new name?", preferredStyle: .alert)
        
        alert.addTextField()
        let textField = alert.textFields![0]
        textField.text = person.name
        
        let submit = UIAlertAction(title: "Rename", style: .default){ (action) in
            
            person.name = textField.text
            person.age = 20
            
            do{
                try self.context.save()
            }
            catch let error{
                print(error)
            }
            
            self.fetchPeople()
        }
        
        alert.addAction(submit)
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let personToRemove = self.items![indexPath.row]
            
            self.context.delete(personToRemove)
            
            do{
                try self.context.save()
            }
            catch let err{
                print(err)
            }
            
            self.fetchPeople()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

