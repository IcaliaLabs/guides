//
//  ViewControllerSpec.swift
//  ILTestingDemo
//
//  Created by Compean on 03/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import ILTestingDemo

class ViewControllerSpec: QuickSpec {
        
    override func spec() {
        var viewController: ViewController!
        var navigationController: UINavigationController!
        
        beforeEach {
            navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            viewController = navigationController.topViewController as! ViewController
            _ = viewController.view
        }
        
        describe("the user label") {
            context("when view has just loaded") {
                
                it("should not be nil") {
                    expect(viewController.selectedUserLabel).toNot(beNil())
                }
                
                it("should tell the user that no user has been selected") {
                    expect(viewController.selectedUserLabel?.text).to(equal(NSLocalizedString("NO_USER_SELECTED_TEXT", comment: "")))
                }
            }
        }
        
        describe("the button") {
            context("when pressed") {
                beforeEach{
                    viewController.user = Person(name: "Monica", lastName: "Geller")!
                    viewController.performSegueWithIdentifier("userTableSegue", sender: nil)
                }
                
                it("should present the user table view") {
                    expect(navigationController.topViewController).toEventually(beAnInstanceOf(UserTableViewController), timeout: 4)
                }
                
                it("should tell the presenting table which user was selected") {
                    expect((navigationController.topViewController as? UserTableViewController)?.selectedUser).toEventually(equal(viewController.user), timeout: 4)
                }
            }
        }
    }
    
}
