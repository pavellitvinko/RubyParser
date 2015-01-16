//
//  NodeGraph.swift
//  parser
//
//  Created by Pavel Litvinko on 27.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class ProgramGraph<T: Node>: Graph<T> {

    private func visitVertex(visitor: NodeVisitor, vertex: Vertex<T>){
        if let node = vertex.key {
            node.accept(visitor)
        }
        for edge in vertex.neighbors {
            visitor.visitEdge(edge)
            visitVertex(visitor, vertex: edge.neighbour)
        }
    }
    
    func acceptVisitor(visitor: NodeVisitor) {
        if let head = self.getHead(){
            visitVertex(visitor, vertex: head)
        }
    }
}
