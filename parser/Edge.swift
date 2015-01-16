//
//  Edge.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

public class Edge<T>: Node, EdgeNode {
    
    var neighbour: Vertex<T>
    var weight: Int
    
    init() {
        weight = 0
        self.neighbour = Vertex()
        super.init("")
    }
    
    override func accept(visitor: NodeVisitor){
        visitor.visitEdge(self)
    }
}
