//
//  WhenStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 23.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa
import ExSwift

class WhenStatement: Statement {

    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (\s*?when\s)
        
        return line =~ "(\\s*?when\\s)"
    }

    override func getBeforeBlockAffect() -> BlockType {
        return BlockType.Ends
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.Starts
    }
}
