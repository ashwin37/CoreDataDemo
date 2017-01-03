//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Rakesh Viparla on 10/7/16.
//  Copyright © 2016 adroit37. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,DetailDataSource{
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var employees = [Employee]()
    
    @IBOutlet weak var empTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empTableView.dataSource = self
        empTableView.delegate = self
        fetchEmployee()
        
        self.navigationItem.leftBarButtonItem = editButtonItem()
        
    }

    override func setEditing(editing: Bool, animated: Bool) {
        empTableView.setEditing(editing, animated: animated)
        super.setEditing(editing, animated: animated)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            managedObjectContext.deleteObject(employees[indexPath.row])
            employees.removeAtIndex(indexPath.row)
            empTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is SecViewController{
            (segue.destinationViewController as! SecViewController).detailDataSource = self
            if segue.identifier == "segue_edit_emp"{
              
                let selectedRowIndePath = empTableView.indexPathForSelectedRow!
                (segue.destinationViewController as! SecViewController).employee = employees[selectedRowIndePath.row]
                
            }
        }
    }
    
    func onAddContents(name:String, age:String, location:String)
    {
        self.navigationController?.popViewControllerAnimated(true)
        if let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as? Employee{
            
            employee.name = name
            employee.age = age
            employee.location = location
            
        }
        do{
           try managedObjectContext.save()
            print("Saved Successfully!!")
            fetchEmployee()

        }
        catch{
              print((error as NSError).localizedDescription)
        }
    }
    
    func onUpdateEmployee(employee:Employee)
    {
        self.navigationController?.popViewControllerAnimated(true)
        do{
            try managedObjectContext.save()
            fetchEmployee()

        }
        catch{
            print(error)
        }
    }
    
    func fetchEmployee() {
        let entity = NSEntityDescription.entityForName("Employee", inManagedObjectContext: managedObjectContext)
      let fetchReq = NSFetchRequest()
        fetchReq.entity = entity
        
        do{
       employees = try managedObjectContext.executeFetchRequest(fetchReq) as! [Employee]
            empTableView.reloadData()

        }
        catch{
            print(error)

        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let employee = employees[indexPath.row]
        cell.textLabel?.text = "\(employee.name)"
        cell.detailTextLabel?.text = "\(employee.age) \(employee.location)"
        return cell
    }
}

