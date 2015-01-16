//
//  ConditionNode.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

class ConditionNode: Node {
    var predicatesCount = 0
    
    init(_ title: String, predicatesCount: Int = 0) {
        self.predicatesCount = predicatesCount
        super.init(title)
    }
    
    override func accept(visitor: NodeVisitor){
        visitor.visitConditionNode(self)
    }
    
}
