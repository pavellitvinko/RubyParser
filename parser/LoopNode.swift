//
//  LoopNode.swift
//  parser
//
//  Created by Pavel Litvinko on 29.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class LoopNode: Node {

    override func accept(visitor: NodeVisitor){
        visitor.visitLoopNode(self)
    }

}
