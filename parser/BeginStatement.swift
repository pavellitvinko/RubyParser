//
//  BeginStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 28.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa
import ExSwift

class BeginStatement: Statement {

    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?end\s*?
        
        return line =~ "\\s*?begin\\s*?"
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.StartsBlock
    }
    
    override func buildNode(title: String) -> Node? {
        return OperatorNode(title)
    }

}
