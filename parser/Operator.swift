//
//  Operator.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa
import ExSwift

class Operator: Statement {

    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (!|=|>|<|==|\+|-|\*|\/|%|\*|\||&|\^|~|\.)+=?
        
        return line =~ "(!|=|>|<|==|\\+|-|\\*|\\/|%|\\*|\\||&|\\^|~|\\.)+=?"
    }
    
    override func buildNode(title: String) -> Node? {
        return OperatorNode(title)
    }
}
