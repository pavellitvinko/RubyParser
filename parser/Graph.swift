//
//  Graph.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

public class Graph<T>{
    private var items: Array<Vertex<T>>
    public var isDirected: Bool
    
    init() {
        items = Array<Vertex<T>>()
        isDirected = true
    }
    
    convenience init(isDirected: Bool) {
        self.init()
        self.isDirected = isDirected
    }
    
    func addVertex(key: T) -> Vertex<T> {
        //set the key
        var childVertex: Vertex<T> = Vertex<T>()
        childVertex.key = key
        
        //add the vertex to the graph
        items.append(childVertex)
        
        return childVertex
    }
    
    func addEdge(source: Vertex<T>, neighbour: Vertex<T>, weight: Int) {
        var newEdge = Edge<T>()
        
        //establish the default properties
        newEdge.neighbour = neighbour
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        //check for undirected graph
        if (isDirected == false) {
            
            //create a new reversed edge
            var reverseEdge = Edge<T>()
            
            //establish the reversed properties
            reverseEdge.neighbour = source
            reverseEdge.weight = weight
            neighbour.neighbors.append(reverseEdge)
        }
    }
    
    func getHead() ->  Vertex<T>?{
        if items.count > 0 {
            return items[0]
        } else {
            return nil
        }
    }
}
