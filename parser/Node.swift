//
//  Node.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

public class Node {
    var title = ""
    
    init(_ title: String)
    {
        self.title = title
    }
    
    func accept(visitor: NodeVisitor){
        visitor.visitNode(self)
    }
}
