//
//  swElseStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftElseStatement: Statement {
    var hasIfStatement: Bool = false
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?if\s*?
        hasIfStatement = line =~ "\\s*?if\\s*?"
        
        if hasIfStatement {
            return true
        } else {
            //orig: \s*?else\s*?
            return line =~ "\\s*?else\\s*?"
        }
    }
    
    override func buildNode(title: String) -> Node? {
        if hasIfStatement {
            return ConditionNode(title)
        }
        return nil
    }
    
    override func getBeforeBlockAffect() -> BlockType {
        return BlockType.Ends
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.Starts
    }
    
    
}
