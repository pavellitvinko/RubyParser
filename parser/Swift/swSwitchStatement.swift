//
//  swSwitchStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftSwitchStatement: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (\s*?switch\s)
        
        return line =~ "(\\s*?switch\\s)"
    }
    
    override func buildNode(title: String) -> Node? {
        return ConditionNode(title)
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.StartsBlock
    }
    
}
