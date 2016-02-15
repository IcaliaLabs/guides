//
//  PersonServiceMock.swift
//  ILTestingDemo
//
//  Created by Compean on 01/02/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Foundation
import PromiseKit
@testable import ILTestingDemo

enum Result<T> {
    case Success(T)
    case Failure(ErrorType)
}

enum PersonServiceMockError: ErrorType {
    case NoResultForTestSet
}

class PersonServiceMock: PersonService {
    var fakeResult: Result<[Person]> = Result.Failure(PersonServiceMockError.NoResultForTestSet)
    
    override func fetchAllPeople() -> Promise<[Person]> {
        switch fakeResult {
        case .Success(let people):
            return Promise(people)
        case .Failure(let error):
            return Promise(error: error)
        }
    }
}