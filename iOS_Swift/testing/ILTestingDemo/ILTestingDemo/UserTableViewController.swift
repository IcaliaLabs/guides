//
//  UserTableViewController.swift
//  ILTestingDemo
//
//  Created by Compean on 03/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import UIKit

class UserTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedUser: Person?
    var people: [Person]?
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllPeople()
    }

//    func fetchAllPeople(personService: PersonService = PersonService()) {
//        personService.fetchAllPeople().then { (people) -> Void in
//            self.people = people
//            self.peopleTableView.reloadData()
//        }.error {
//            error in
//            let alertController = UIAlertController(title: "Error", message: "Couldn't fetch people", preferredStyle: UIAlertControllerStyle.Alert)
//            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
//            alertController.addAction(alertAction)
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//    }
    
    func fetchAllPeople(personType: Person.Type = Person.self) {
        personType.fetchAll().then {
            (people) -> Void in
                self.people = people
                self.peopleTableView.reloadData()
            }.error {
                error in
                let alertController = UIAlertController(title: "Error", message: "Couldn't fetch people", preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath)
        cell.textLabel?.text = people?[indexPath.row].fullName
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 0
    }
}
