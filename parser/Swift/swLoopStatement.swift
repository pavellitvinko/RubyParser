//
//  swLoopStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftLoopStatement: Statement {
    var isPostfixStatement: Bool = false
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?while|for\s+?
        if line =~ "\\s*?while|for\\s+?" {
            
            
            //orig: \s*?}\s+?(while)
            isPostfixStatement  = (line =~ "\\s*?\\}\\s+?(while)")
            
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
                return BlockType.Starts
            
        }
    }
    
}
