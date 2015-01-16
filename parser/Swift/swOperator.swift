//
//  Operator.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftOperator: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (!|=|>|<|==|\+|-|\*|\/|%|\*|\||&|\^|~|\.)+=?
        
        return line =~ "(!|=|>|<|==|\\+|-|\\*|\\/|%|\\*|\\||&|\\^|~|\\.)+=?"
    }
    
    override func buildNode(title: String) -> Node? {
        return OperatorNode(title)
    }
}
