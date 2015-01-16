//
//  swCaseStatement.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftCaseStatement: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        //orig: (\s*?case\s.*:)|(\s*?where\s.*:)
        
        return line =~ "(\\s*?case\\s.*:)|(\\s*?where\\s.*:)"
    }
    
    override func getBeforeBlockAffect() -> BlockType {
        return BlockType.Ends
    }
    
    override func getAfterBlockAffect() -> BlockType {
        return BlockType.Starts
    }
}

