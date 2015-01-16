//
//  OperatorNode.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

class OperatorNode: Node {
    
    override func accept(visitor: NodeVisitor){
        visitor.visitOperatorNode(self)
    }
    
}
