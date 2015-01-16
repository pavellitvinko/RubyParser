//
//  Parser.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa

extension Array {
    func contains<T : Equatable>(obj: T) -> Bool {
        let filtered = self.filter {$0 as? T == obj}
        return filtered.count > 0
    }
}

class Parser {
    var builder: ProgramGraphBuilder
    var statements = [Statement]()
    
    init(){
        builder = RubyGraphBuilder()

        // Order is have sense!
        statements.append(SwiftComment())
        statements.append(SwiftConditionStatement())
        statements.append(SwiftElseStatement())
        statements.append(SwiftSwitchStatement())
        statements.append(SwiftCaseStatement())
        statements.append(SwiftLoopStatement())
        statements.append(SwiftBeginStatement())
        statements.append(SwiftEndStatement())
        statements.append(SwiftOperator())
    }

    
    func parse(reader: StreamReader) -> ProgramGraph<Node>?
    {
         while var s = reader.nextLine() {
           s = s.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
           if !s.isEmpty{
            var statementRecognized = false
            for statement in statements {
                if statement.test(s, reader: reader) {

                    applyNestingAffect(statement.getBeforeBlockAffect());
                    
                    
                    if let node = statement.buildNode(s.trimmed()) {
                        builder.addNode(node)
                    }
                    printStatement(statement)
                    
                    applyNestingAffect(statement.getAfterBlockAffect());
                    
                    statementRecognized = true
                    break;
                }
            }
            
            if !statementRecognized {
                if let node = Operator().buildNode(s) {
                    builder.addNode(node)
                }
                printStatement(Operator())
            }
            println("\(s)")
            }
        }
        if builder.nestingLevel() != 0 {
              return nil
        }
        return builder.getGraph()
    }
    
    func applyNestingAffect(blockType: BlockType){
        switch blockType {
            
        case BlockType.Starts:
            builder.increaseNesting()
        case BlockType.Ends:
            builder.decreaseNesting()
        case BlockType.StartsBlock:
            builder.beginNestingBrunches()
        case BlockType.EndsBlock:
            builder.mergeNestingBrunches()
        default:
            break
        }
    }
    
    func printStatement(statement: Statement){
        let prefix = String(count: builder.nestingLevel(), repeatedValue: Character("-"))
        print("\(prefix)\(statement): ")
    }

}
