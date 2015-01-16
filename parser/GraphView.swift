//
//  GraphView.swift
//  parser
//
//  Created by Pavel Litvinko on 29.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class GraphView: NSView {
    let vertexSize: CGFloat = 20.0
    let vertexWidth: CGFloat = 180.0
    let intervalSize: CGFloat = 40.0
    var displayedVertexes: [(Vertex<Node>, NSPoint)] = []
    
    var sourceGraph: Graph<Node>?
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        clear()
        if let graph = sourceGraph {
            displayBrunch(NSMakePoint(100, super.bounds.size.height - 50 ), startVertex: graph.getHead()!)
        }
    }
    
    func displayBrunch(startPoint: NSPoint, startVertex curVertex: Vertex<Node>) {
        
        let (visited, point) = checkVisited(curVertex)
        
        if visited {
            drawConnectionLine(from: NSMakePoint(startPoint.x + vertexSize / 2, startPoint.y + vertexSize / 2 + (intervalSize + vertexSize)),
                                to: NSMakePoint(point!.x + vertexSize, point!.y + vertexSize / 2))
            
            return
        } else {
            displayedVertexes.append(curVertex, startPoint)
        }
        
        for var i = 0; i < curVertex.neighbors.count; ++i {
            
            var brunchesCount = 0
            if i > 0{
                brunchesCount = countBrunches(forVertex: curVertex.neighbors[i-1].neighbour)
            }
            
            let (visited, _) = checkVisited(curVertex.neighbors[i].neighbour)
            let currentVertexCenterPoint = NSMakePoint(startPoint.x + vertexSize / 2, startPoint.y + vertexSize / 2)
            
            let nextVertexX = startPoint.x + CGFloat(Float(i)) * (intervalSize + vertexSize + vertexWidth) * CGFloat(Float(brunchesCount + 1))
            var nextVertexY = startPoint.y - (intervalSize + vertexSize)
            
            if visited {
                drawConnectionLine(from: currentVertexCenterPoint, to: NSMakePoint(nextVertexX + vertexSize / 2, startPoint.y + vertexSize / 2))
            } else {
                drawConnectionLine(from: currentVertexCenterPoint, to: NSMakePoint(nextVertexX + vertexSize / 2, nextVertexY + vertexSize / 2))
            }
            
            displayBrunch(NSMakePoint(nextVertexX, nextVertexY), startVertex: curVertex.neighbors[i].neighbour)
        }
        
        drawVertex(startPoint)
        drawText(curVertex.key!.title, rect: NSMakeRect(startPoint.x + vertexSize, startPoint.y + vertexSize/2, vertexWidth, vertexSize))
    }
    
    func clear() {
        displayedVertexes = []
    }
    
    func checkVisited(vertex: Vertex<Node>)  -> (Bool, NSPoint?) {
        for (v,p) in displayedVertexes {
            if v === vertex {
                return (true, p)
            }
        }
        return (false, nil)
    }
    
    func countBrunches(forVertex vertex: Vertex<Node>) -> Int {
        if vertex.neighbors.count < 2 {
            return 0
        }
        
        var res: Int = 0
            for i in 0..<vertex.neighbors.count {
                res += 1 + Int(countBrunches(forVertex: vertex.neighbors[i].neighbour))
            }
            res -= 1
        return res
    }
    
    func drawVertex(point: NSPoint){
        let strokeColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let fillColor = NSColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1.0)
        let circleRect = NSMakeRect(point.x, point.y, vertexSize, vertexSize)
        let cPath = NSBezierPath(ovalInRect: circleRect)
        fillColor.set()
        cPath.fill()
        strokeColor.set()
        cPath.stroke()
    }
    
    func drawConnectionLine(#from: NSPoint, to: NSPoint){
        let strokeColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.35)
        var bPath:NSBezierPath = NSBezierPath()
        bPath.moveToPoint(from)
        if from.x > to.x {
        bPath.curveToPoint(to, controlPoint1: NSMakePoint(from.x, to.y), controlPoint2: NSMakePoint(from.x, to.y))
        } else {
           bPath.curveToPoint(to, controlPoint1: NSMakePoint(to.x, from.y), controlPoint2: NSMakePoint(to.x, from.y))
        }
        bPath.lineToPoint(to)
        bPath.lineWidth = 3
        strokeColor.set()
        bPath.stroke()
    }
    
    func drawText(text: String, rect: NSRect){
        let text: NSString = text
        let font = NSFont(name: "Helvetica Bold", size: 14.0)
        
        if let actualFont = font {
            let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.LeftTextAlignment
            let textColor = NSColor(calibratedRed: 0.147, green: 0.222, blue: 0.162, alpha: 1.0)

            
            let textFontAttributes = [
                NSFontAttributeName: actualFont,
                NSForegroundColorAttributeName: textColor,
                NSParagraphStyleAttributeName: textStyle
            ]
            
            text.drawInRect(NSOffsetRect(rect, 0, 1), withAttributes: textFontAttributes)
        }
    }
}
