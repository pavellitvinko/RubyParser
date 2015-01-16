//
//  SwitchStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 23.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa
import ExSwift

class CaseStatement: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (\s*?case\s)
        
        return line =~ "(\\s*?case\\s)"
    }
    
    override func buildNode(title: String) -> Node? {
        return ConditionNode(title)
    }

    override func getAfterBlockAffect() -> BlockType {
        return BlockType.StartsBlock
    }
    
}
