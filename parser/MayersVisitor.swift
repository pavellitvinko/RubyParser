//
//  MayersVisitor.swift
//  parser
//
//  Created by Pavel Litvinko on 29.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class MayersVisitor: McCabeVisitor {
    var totalPredicatesCount = 0
    
    override func visitConditionNode(node: ConditionNode){
        totalPredicatesCount += node.predicatesCount
        super.visitConditionNode(node)
    }
    
}
