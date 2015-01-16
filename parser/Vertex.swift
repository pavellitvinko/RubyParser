//
//  Vertex.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

public class Vertex<T> {
    var key: T?
    var neighbors: [Edge<T>]
    
    init() {
        self.key = nil
        self.neighbors = [Edge<T>]()
    }
}
