//
//  End.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa
import ExSwift

class EndStatement: Statement {

    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?end\s*?
        
        return line =~ "\\s*?end\\s*?"
    }

    override func getAfterBlockAffect() -> BlockType {
        return BlockType.EndsBlock
    }
    
    override func buildNode(title: String) -> Node? {
        return EndNode(title)
    }
}
