//
//  Person.swift
//  ILTestingDemo
//
//  Created by Compean on 29/01/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Foundation
import PromiseKit

public func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.lastName == rhs.lastName
}

public class Person:Equatable, CustomStringConvertible {
    let name: String
    let lastName: String
    var fullName: String {
        return "\(name) \(lastName)"
    }
    public var description: String {
        return "<Person: {name:\(name), lastname:\(lastName)}>"
    }
    
    init?(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
        if self.name == "" || self.lastName == "" {
            return nil
        }
    }
    
    class func fetchAll() -> Promise<[Person]> {
        return Promise {
            fulfill, reject in
            
            let request = NSURLRequest(URL: NSURL(string: "https://dummy.server.com/people")!)
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    fulfill(people(data))
                }
            }).resume()
        }
    }
    
    private class func people(fromData: NSData) -> [Person] {
        return [
            Person(name: "Bianca", lastName: "Smith")!,
            Person(name: "monica", lastName: "Jones")!,
            Person(name: "Tim", lastName: "Turner")!,
            Person(name: "Tony", lastName: "Stark")!,
            Person(name: "Sasha", lastName: "Minsk")!,
            Person(name: "Emily", lastName: "Carrey")!]
    }
}