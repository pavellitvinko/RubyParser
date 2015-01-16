//
//  EndNode.swift
//  parser
//
//  Created by Pavel Litvinko on 25.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class EndNode: Node {
    
    override func accept(visitor: NodeVisitor){
        visitor.visitEndNode(self)
    }
}
