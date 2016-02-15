//
//  PersonSpec.swift
//  ILTestingDemo
//
//  Created by Compean on 29/01/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Quick
import Nimble
@testable import ILTestingDemo

class PersonSpec: QuickSpec {
        
    override func spec() {
        let personSample = Person(name: "Monica", lastName: "Geller")!
        
        describe("full name") {
            context("when required") {
                it("should always have the right info") {
                    expect(personSample.fullName).to(equal("Monica Geller"))
                }
            }
        }
        
        describe("a person") {
            context("when compared for equality to another person") {
                let anotherPerson = Person(name: "Monica", lastName: "Geller")!
                let anotherPersonWithDifferentName = Person(name: "Monica", lastName: "Schultz")!
                
                it("should be considered the same as long as the name and lastname are equal") {
                    expect(personSample == anotherPerson).to(beTrue())
                    expect(personSample == anotherPersonWithDifferentName).to(beFalse())
                }
            }
            
            context("when intantiating with name and lastname parameters") {
                let name = "Timmy"
                let lastName = "Turner"
                let person = Person(name: name, lastName: lastName)!
                it("must reflect that result when being used") {
                    expect(person.name) == name
                    expect(person.lastName) == lastName
                }
                
                it("must always have a name and a lastname") {
                    expect(Person(name: "", lastName: "")).to(beNil())
                    expect(Person(name: "", lastName: "Morgan")).to(beNil())
                    expect(Person(name: "Jack", lastName: "")).to(beNil())
                    expect(Person(name: "Jack", lastName: "Morgan")).toNot(beNil())
                }
            }
        }
    }
}
