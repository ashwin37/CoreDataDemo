//
//  SecViewController.swift
//  CoreDataDemo
//
//  Created by Rakesh Viparla on 10/7/16.
//  Copyright © 2016 adroit37. All rights reserved.
//

import UIKit

protocol DetailDataSource {
    
    func onUpdateEmployee(employee:Employee)
    func onAddContents(name:String, age:String, location:String)
}
class SecViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    var employee:Employee?
    var detailDataSource:DetailDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let employee = employee {
            
            nameTF.text = employee.name
            ageTF.text = employee.age
            locationTF.text = employee.location
        }
    }

    @IBAction func saveContents(sender: AnyObject) {
        
        guard let name = nameTF.text else {return}
        guard let age = ageTF.text else {return}
        guard let location = locationTF.text else {return}
      
        if employee == nil{
        if let dataSource = detailDataSource{
            
        dataSource.onAddContents(name, age: age, location: location)
        
        }
    }
        else{
            employee?.name = name
            employee?.age = age
            employee?.location = location
            
            if let dataSource = detailDataSource{
                
                dataSource.onUpdateEmployee(employee!)            }
        }
    
    }
    
    
    
}
