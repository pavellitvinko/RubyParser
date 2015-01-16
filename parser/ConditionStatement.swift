//
//  Condition.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa
import ExSwift

class ConditionStatement: Statement {
    var isModifierStatement: Bool = false
    var predicatesCount = 0

    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (^\s*?(if|unless)\s)|(\?\s.*:)
        
        isModifierStatement = (line =~ "(\\s*?(if|unless)\\s)|(\\?\\s.*:)") &&
                             !(line =~ "(^\\s*?(if|unless)\\s)|(\\?\\s.*:)")
        
        //orig: (!|=|>|<|==|\+|-|\*|\/|%|\*|\||&|\^|~)+=?
        let matches = line.matches("(!|=|>|<|==|\\+|-|\\*|\\/|%|\\*|\\||&|\\^|~)+=?")!
        predicatesCount = max(matches.count - 1, 0)
        
        if isModifierStatement {
            return true
        } else {
            //orig: (\s*?(if|unless)\s)|(\?\s.*:)
            return line =~ "(\\s*?(if|unless)\\s)|(\\?\\s.*:)"
        }
    }
    
    override func buildNode(title: String) -> Node? {
        return ConditionNode(title, predicatesCount: predicatesCount)
    }
    
    override func getAfterBlockAffect() -> BlockType {
        if !isModifierStatement {
            return BlockType.StartsBlock
        } else {
            return BlockType.Continues
        }
    }
}
