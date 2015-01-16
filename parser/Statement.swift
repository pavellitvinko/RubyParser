//
//  Statement.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

enum BlockType {
    case Starts, Ends, Continues, StartsBlock, EndsBlock
}

class Statement: NodeBuilder {
    func test(line: String, reader: StreamReader) -> Bool{
        return false
    }
    
    func buildNode(title: String) -> Node? {
        return nil
    }
    
    func getBeforeBlockAffect() -> BlockType {
        return BlockType.Continues
    }
    
    func getAfterBlockAffect() -> BlockType {
        return BlockType.Continues
    }
}


extension Statement {
    func className() -> String {
        return _stdlib_getTypeName(self)
    }
}
