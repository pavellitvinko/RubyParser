//
//  ConditionStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftConditionStatement: Statement {
    var predicatesCount = 0
    
    override func test(line: String, reader: StreamReader) -> Bool {
       
        //orig: (!|=|>|<|==|\+|-|\*|\/|%|\*|\||&|\^|~)+=?
        let matches = line.matches("(!|=|>|<|==|\\+|-|\\*|\\/|%|\\*|\\||&|\\^|~)+=?")!
        predicatesCount = max(matches.count - 1, 0)
        
        //orig: (\s*?if\s)
            return line =~ "(\\s*?if\\s)"
        
    }
    
    override func buildNode(title: String) -> Node? {
        return ConditionNode(title, predicatesCount: predicatesCount)
    }
    
    override func getAfterBlockAffect() -> BlockType {
            return BlockType.StartsBlock
    }
}
