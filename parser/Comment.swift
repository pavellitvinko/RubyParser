//
//  Comment.swift
//  parser
//
//  Created by Pavel Litvinko on 17.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa
import ExSwift

class Comment: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        return isSingleLineComment(line) || isMultilineComment(line, reader)
    }
    
    func isSingleLineComment(line: String) -> Bool{
        return line =~ "^\\s*?#(.*?)"
        //   puts("Inside the loop i = #$i" )!!!
    }
    
    func isMultilineComment(line: String, _ reader: StreamReader) -> Bool{
        if line =~ "^=begin" {
            var endFound = false
            while let s = reader.nextLine() {
                if s =~ "^=end" {
                    endFound = true
                    break
                }
            }
            if endFound {
                return true
            }
        }
        return false
    }

}
