//
//  ViewController.swift
//  ILTestingDemo
//
//  Created by Compean on 29/01/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectUserButton: UIButton!
    @IBOutlet weak var selectedUserLabel: UILabel!
    var user: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedUserLabel.text = NSLocalizedString("NO_USER_SELECTED_TEXT", comment: "No user selected")
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userTableSegue" {
            let userTableController = segue.destinationViewController as! UserTableViewController
            userTableController.selectedUser = user
        }
    }
}

