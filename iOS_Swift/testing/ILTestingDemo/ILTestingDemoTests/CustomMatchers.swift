//
//  CustomMatchers.swift
//  TestingINiOS
//
//  Created by Compean on 28/01/16.
//  Copyright © 2016 Compean. All rights reserved.
//

import Quick
import Nimble
import UIKit
//@testable import ILTestingDem

struct CustomMatchers {
    
    static func matchEachCell<T: protocol<Equatable, CustomStringConvertible>>(info infoFromCell: (UITableViewCell) -> (T), withCorresponding correspondingElements: [T]) -> MatcherFunc<UITableView> {
        return MatcherFunc { actual, failureMessage in
            
            if let tableView: UITableView = try actual.evaluate() {
                if let numberOfRows = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0) {
                    for index in 0 ..< numberOfRows {
                        if let cell = tableView.dataSource?.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)) {
                            let cellInfo = infoFromCell(cell)
                            if (cellInfo != correspondingElements[index]) {
                                failureMessage.actualValue = "<" + cellInfo.description + ">"
                                failureMessage.postfixMessage = "match <\(correspondingElements[index])> at index \(index)"
                                return false
                            }
                        }
                    }
                }
                return true
            }
            
            return false
            
        }
    }
    
}