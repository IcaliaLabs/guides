//
//  UserTableViewControllerSpec.swift
//  ILTestingDemo
//
//  Created by Compean on 03/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import ILTestingDemo

class UserTableViewControllerSpec: QuickSpec {
    
    override func spec () {
        var userTableController: UserTableViewController!
        let allPeople = [Person(name: "jacob", lastName: "Wells")!, Person(name: "jessica", lastName: "Parker")!]
        beforeEach {
            userTableController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("userTableViewController") as! UserTableViewController
            _ = userTableController.view
        }
        
        describe("a fetch for users") {
            context("when succesful") {
                beforeEach {
//                    let service = PersonServiceMock()
//                    service.fakeResult = Result.Success(allPeople)
//                    userTableController.fetchAllPeople(service)
                    PersonMockFetchAllSuccess.allPeople = allPeople
                    userTableController.fetchAllPeople(PersonMockFetchAllSuccess.self)
                }
                
                it("should update the users") {
                    expect(userTableController.people).toEventually(equal(allPeople), timeout: 3)
                }
            }
            
            context("when failed to retrieve users") {
                beforeEach {
                    UIApplication.sharedApplication().keyWindow!.rootViewController = userTableController
                    enum ServerError: ErrorType {
                        case ServerUnreachable
                    }
                    
//                    let service = PersonServiceMock()
//                    service.fakeResult = Result.Failure(ServerError.ServerUnreachable)
//                    userTableController.fetchAllPeople(service)
                    PersonMockFetchAllError.error = ServerError.ServerUnreachable
                    userTableController.fetchAllPeople(PersonMockFetchAllError.self)
                }
                
                it("should show an alert about the error") {
                    expect(userTableController.presentedViewController).toEventually(beAnInstanceOf(UIAlertController), timeout: 4)
                }
            }
        }
        
        describe("table view") {
            context("when all people have been fetched sucessfully") {
                beforeEach {
                    userTableController.people = allPeople
                }
                
                it("has as many rows as people in it") {
                expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, numberOfRowsInSection: 0)) == userTableController.people!.count
                }
                
                it("displays a persons full name for each row") {
                    let peopleFullNames: [String] = userTableController.people!.map{person in person.fullName}
                    expect(userTableController.peopleTableView).to(CustomMatchers.matchEachCell(info:{
                        cell in
                        return cell.textLabel?.text ?? ""
                        }, withCorresponding: peopleFullNames))
                    
//                    for (index, person) in userTableController.people!.enumerate() {
//                        expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)).textLabel?.text).to(equal(person.fullName))
//                        
//                    }
                }
            }
            
            context("when there is no people") {
                beforeEach {
                    userTableController.people = nil
                }
                
                it("has cero rows in it") {
                    expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, numberOfRowsInSection: 0)) == 0
                }
            }
        }
    }
    
}
