//
//  PersonMock.swift
//  ILTestingDemo
//
//  Created by Compean on 03/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Nimble
import Quick
import PromiseKit
@testable import ILTestingDemo

enum PersonMockError: ErrorType {
    case NoResultForTestSet
}

class PersonMock: Person {
    enum Result {
        case Success([Person])
        case Error(ErrorType)
    }
    
    class var fakeResult: Result {
        return Result.Error(PersonMockError.NoResultForTestSet)
    }
    
    override class func fetchAll() -> Promise<[Person]> {
        switch fakeResult {
        case .Success(let people):
            return Promise(people)
        case .Error(let error):
            return Promise(error: error)
        }
    }
}

class PersonMockFetchAllSuccess: PersonMock {
    static var allPeople: [Person]!
    
    override class var fakeResult: Result {
        return PersonMock.Result.Success(allPeople)
    }
}

class PersonMockFetchAllError: PersonMock {
    static var error: ErrorType!
    
    override class var fakeResult: Result {
        return PersonMock.Result.Error(error)
    }
}