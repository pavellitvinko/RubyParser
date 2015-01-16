//
//  EndStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftEndStatement: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: \s*?}\s*?
        
         return (line =~ "\\s*?\\}\\s*?") && !(line =~ "\\s*?\\{\\s*?")
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.EndsBlock
    }
    
    override func buildNode(title: String) -> Node? {
        return EndNode(title)
    }
}
