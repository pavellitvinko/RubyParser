//
//  SpenVisitor.swift
//  parser
//
//  Created by Pavel Litvinko on 30.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa
import ExSwift

extension String {
    public func convertRange(range: NSRange) -> Range<String.Index> {
        let startIndex = advance(self.startIndex, range.location)
        let endIndex = advance(self.startIndex, range.length)
        return Range<String.Index>(start: startIndex, end: endIndex)
    }

}
extension Node {
    func getIdentifiers() -> [String] {
        //orig: ([A-za-z0-9-.])
        if title.isEmpty {
            return []
        }
        var identifiers: [String] = []
        
        let isKeyWord = title =~ "}\\s(def|begin|end|if|elif|else|while|do|until|nil|case|when|raise|let|import|class|private|extension|func|return)\\s"
        
        //let regex = ExSwift.regex("([A-za-z0-9-.])", ignoreCase: false)!
        //let matches = regex.matchesInString(title, options: nil, range: NSMakeRange(0, title.length))
        
        
        let matches = title.matches("([A-za-z0-9-.])")!
        for match in matches{
           // let range = Range(start: match.range.location, end: match.range.location + match.range.length)
            
            let s = title.substringWithRange(title.convertRange(match.range))
            let isKeyWord = s =~ "(def|begin|end|if|elif|else|while|do|until|nil|case|when|raise)"
           
        }
        return []
    }
}

class SpenVisitor: NodeVisitor {
    var visitedNodes: [Node] = []
    var identifiers: [String] = []
    
    func visitOperatorNode(node: OperatorNode){
        visitNode(node)
    }
    func visitConditionNode(node: ConditionNode){
        visitNode(node)
    }
    
    func visitLoopNode(node: LoopNode){
        visitNode(node)
    }
    func visitEndNode(node: EndNode){
        visitNode(node)
    }
    func visitNode(node: Node){
        println("Visited: \(node.title)")
        if !checkAndMarkAsVisited(node) {
            identifiers.extend(node.getIdentifiers())
        }
    }
    
    func visitEdge(edge: EdgeNode) {
    }

    
    func checkAndMarkAsVisited(node: Node) -> Bool{
        for n in visitedNodes {
            if n === node {
                return true
            }
        }
        visitedNodes.append(node)
        return false
    }
    
}
