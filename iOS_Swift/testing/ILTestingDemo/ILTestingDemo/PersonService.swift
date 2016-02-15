//
//  PersonService.swift
//  ILTestingDemo
//
//  Created by Compean on 01/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Foundation
import PromiseKit

class PersonService {
    
    func fetchAllPeople() -> Promise<[Person]> {
        return Promise {
            fulfill, reject in
            
            let request = NSURLRequest(URL: NSURL(string: "https://dummy.server.com/people")!)
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    fulfill(self.people(data))
                }
            })
        }
    }
    
    private func people(fromData: NSData) -> [Person] {
        return [
            Person(name: "Bianca", lastName: "Smith")!,
            Person(name: "monica", lastName: "Jones")!,
            Person(name: "Tim", lastName: "Turner")!,
            Person(name: "Tony", lastName: "Stark")!,
            Person(name: "Sasha", lastName: "Minsk")!,
            Person(name: "Emily", lastName: "Carrey")!]
    }
}