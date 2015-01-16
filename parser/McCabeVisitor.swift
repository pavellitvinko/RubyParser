//
//  McCabeVisitor.swift
//  parser
//
//  Created by Pavel Litvinko on 27.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class McCabeVisitor: NodeVisitor {
    var visitedNodes: [Node] = []
    var visitedEdges: [EdgeNode] = []
    var cyclomaticNum = 1
    
    func visitOperatorNode(node: OperatorNode){
        println("Visited Operator: \(node.title)")
        markAsVisited(node)
    }
    func visitConditionNode(node: ConditionNode){
        println("Visited Condition: \(node.title)")
        markAsVisited(node)
    }
    
    func visitLoopNode(node: LoopNode){
        println("Visited Loop: \(node.title)")
        markAsVisited(node)
    }
    func visitEndNode(node: EndNode){
        println("Visited End: \(node.title)")
        markAsVisited(node)
    }
    func visitNode(node: Node){
        println("Visited: \(node.title)")
        markAsVisited(node)
    }
    
    func visitEdge(edge: EdgeNode) {
        markAsVisited(edge)
    }

    func markAsVisited(node: Node){
        for n in visitedNodes {
            if n === node {
                return
            }
        }
        visitedNodes.append(node)
    }
    
    func markAsVisited(edge: EdgeNode){
        for e in visitedEdges {
            if (e === edge) {
                return
            }
        }
        visitedEdges.append(edge)
    }
    
    func getNodesCount() -> Int{
        return visitedNodes.count
    }
    
    func getEdgesCount() -> Int{
        return visitedEdges.count
    }
    
    func getCyclomaticNum() -> Int{
        return getEdgesCount() - getNodesCount() + 2
    }
}
