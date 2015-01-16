//
//  NodeVisitor.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

protocol NodeVisitor {
    func visitOperatorNode(node: OperatorNode)
    func visitConditionNode(node: ConditionNode)
    func visitLoopNode(node: LoopNode)
    func visitEndNode(node: EndNode)
    func visitNode(node: Node)
    func visitEdge(edge: EdgeNode)
}
