//
//  ElseStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa
import ExSwift

class ElseStatement: Statement {
    var hasIfStatement: Bool = false
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?elsif\s*?
        hasIfStatement = line =~ "\\s*?elsif\\s*?"
        
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
