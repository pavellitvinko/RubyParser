//
//  ViewController.swift
//  parser
//
//  Created by Pavel Litvinko on 23.10.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var inputFileNameField: NSTextField!

    @IBOutlet weak var nodesCountField: NSTextField!
    @IBOutlet weak var edgesCountField: NSTextField!
    @IBOutlet weak var cyclomaticNumField: NSTextField!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var predicatesCountField: NSTextField!
    @IBOutlet weak var intervalField: NSTextField!
    @IBOutlet weak var errorField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

 
    @IBAction func test(sender: AnyObject) {
        var reader = StreamReader(path: inputFileNameField.stringValue, delimiters: ["\n","\r",";"], encoding: NSASCIIStringEncoding, chunkSize: 1)
        var parser = Parser()
        
        if let graph = parser.parse(reader) {
            if let head = graph.getHead() {
                let visitor = MayersVisitor()
                let spen = SpenVisitor()
                graph.acceptVisitor(visitor)
                
                nodesCountField.stringValue = "Nodes Count: \(visitor.getNodesCount())"
                edgesCountField.stringValue = "Edges Count: \(visitor.getEdgesCount())"
                cyclomaticNumField.stringValue = "Cyclomatic number: \(visitor.getCyclomaticNum())"
                predicatesCountField.stringValue = "Predicates Count: \(visitor.totalPredicatesCount)"
                
                intervalField.stringValue = "Interval: [\(visitor.getCyclomaticNum()), \(visitor.getCyclomaticNum()+visitor.totalPredicatesCount)]"
                
                
            }
            graphView.sourceGraph = graph
            graphView.display()
            displayError("")
        } else {
            displayError("Unable to parse source code! Bad data?")
        }
    }
    
    func displayError(error: String){
        if error.isEmpty {
            errorField.hidden = true
        } else {
            errorField.stringValue = error
            errorField.hidden = false
        }
    }
    

}

