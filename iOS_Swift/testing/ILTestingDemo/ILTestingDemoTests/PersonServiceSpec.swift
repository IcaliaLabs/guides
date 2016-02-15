//
//  PersonServiceSpec.swift
//  ILTestingDemo
//
//  Created by Compean on 01/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Quick
import Nimble
@testable import ILTestingDemo

/**
* As you can see testing a mock doesn't make much sense as you would be testing a fake class
*/
class PersonServiceSpec: QuickSpec {
    
    override func spec() {
        
        describe("all people request") {
            
            var personService: PersonServiceMock!
            beforeEach {
                personService = PersonServiceMock()
            }
            
            context("when successful") {
                let allPeople = [Person(name: "mandy", lastName: "jones")!]
                var result: [Person]?
                beforeEach {
                    personService.fakeResult = Result.Success(allPeople)
                    personService.fetchAllPeople().then {
                        people in
                        
                        result = people
                    }
                }
                
                it("returns all people") {
                    expect(result).toEventually(equal(allPeople), timeout:3)
                }
            }
            
            context("when it fails") {
                
                enum ServerError: ErrorType {
                    case ServerDown
                }
                
                let serverDownError = ServerError.ServerDown
                var result: ErrorType?
                
                beforeEach {
                    personService.fakeResult = Result<[Person]>.Failure(serverDownError)
                    personService.fetchAllPeople().error {
                        error in
                        
                        result = error
                    }
                }
                
                it("should contain the error information") {
                    expect(result).toEventuallyNot(beNil(), timeout:3)
                }
            }
        }
    }

}
