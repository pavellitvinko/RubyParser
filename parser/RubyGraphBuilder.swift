//
//  RubyGraphBuilder.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

class RubyGraphBuilder: ProgramGraphBuilder {
    var graph: ProgramGraph<Node>
    var curVertex: Vertex<Node>?
    var curBranches: [Vertex<Node>]
    var nestingHeadStack:  [Vertex<Node>]
    var nestingBranchesStack:  [[Vertex<Node>]]
    var doMerge = false
    
    init(){
        graph = ProgramGraph<Node>(isDirected: true)
        curBranches = [Vertex<Node>]()
        nestingHeadStack = [Vertex<Node>]()
        nestingBranchesStack = [[Vertex<Node>]]()
    }
    
    func increaseNesting() {
        if let v = curVertex {
            nestingHeadStack.append(v)
        }
    }
    
    func decreaseNesting() {
        if let v = curVertex {
            if (v !== nestingHeadStack.last){
                curBranches.append(v)
            }
        }
        curVertex = popHeadStack()
    }
    
    func beginNestingBrunches() {
        increaseNesting()

        nestingBranchesStack.append(curBranches)
        curBranches.removeAll(keepCapacity: false)
    }
    
    func mergeNestingBrunches() {
        if curBranches.count > 0 {
            for branch in curBranches {
                graph.addEdge(branch, neighbour: curVertex!, weight: 1)
            }
        }
        
        if let headVertex = popHeadStack() {
            
            // adds connection form "Head" of block to "End" if it not exists and there are no branches
            if curBranches.count == 0 {
                var hasConnection = false
                for edge in headVertex.neighbors {
                    if edge.neighbour === curVertex! {
                        hasConnection = true
                        break
                    }
                }
                
                if !hasConnection {
                    graph.addEdge(headVertex, neighbour: curVertex!, weight: 1)
                }
            }
        }
        
        curBranches = popBranchesStack()
    }
    
    func popHeadStack()->Vertex<Node>?{
        if !nestingHeadStack.isEmpty {
            let head = nestingHeadStack.last
            nestingHeadStack.removeLast()
            return head
        }
        return nil
    }
    
    func popBranchesStack()->[Vertex<Node>]{
        if !nestingBranchesStack.isEmpty {
            let branches = nestingBranchesStack.last!
            nestingBranchesStack.removeLast()
            return branches
        }
        return [Vertex<Node>]()
    }
    
    
    func nestingLevel() -> Int{
        return nestingHeadStack.count
    }
    
    func addNode(node: Node){
        let newVertex = graph.addVertex(node)
        
        if curVertex != nil {
            graph.addEdge(curVertex!, neighbour: newVertex, weight: 1)
        }
        
        curVertex = newVertex
    }
    
    func getGraph() -> ProgramGraph<Node>{
        return self.graph
    }
}
