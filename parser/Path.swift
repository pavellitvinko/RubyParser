//
//  Path.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

class Path<T>{
    
    var total: Int!
    var destination: Vertex<T>
    var previous: Path<T>!
    
    init(){
        destination = Vertex<T>()
    }
}
