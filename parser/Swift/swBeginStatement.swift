//
//  BeginStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftBeginStatement: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?{\s*?
        
        return (line =~ "\\s*?\\{\\s*?") && !(line =~ "\\s*?\\}\\s*?")
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.StartsBlock
    }
    
    override func buildNode(title: String) -> Node? {
        return OperatorNode(title)
    }
    
}
