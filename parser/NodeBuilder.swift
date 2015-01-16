//
//  NodeBuilder.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Foundation

protocol NodeBuilder {
    func buildNode(title: String) -> Node?
}