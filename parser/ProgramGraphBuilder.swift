//
//  NodeBuilder.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

protocol ProgramGraphBuilder {
    func addNode(node: Node)
    func increaseNesting()
    func decreaseNesting()
    func beginNestingBrunches()
    func mergeNestingBrunches()
    func nestingLevel() -> Int
    
    func getGraph() -> ProgramGraph<Node>
}
