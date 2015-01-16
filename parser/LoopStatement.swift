//
//  LoopStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 24.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa
import ExSwift

class LoopStatement: Statement {
    var isModifierStatement: Bool = false
    var isPostfixStatement: Bool = false

    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?while|until|for|.each\s*?do\s)
        if line =~ "\\s*?while|until|for|.each\\s*?do\\s" {
            
            isModifierStatement = !(line =~ "^\\s*?while|until|for|.each\\s*?do\\s")
            
            //orig: ^\s*?end\s*?(while|until)
            isPostfixStatement  = (line =~ "^\\s*?end\\s*?(while|until)")
            
            return true
        } else {
            return false
        }
    }
    
    override func buildNode(title: String) -> Node? {
        return LoopNode(title)
    }
    
    override func getAfterBlockAffect() -> BlockType {
        if isPostfixStatement {
            return BlockType.EndsBlock
        } else {
            if !isModifierStatement {
                return BlockType.Starts
            } else {
                return BlockType.Continues
            }
        }
    }

}
