//
//  Comment.swift
//  parser
//
//  Created by Pavel Litvinko on 26.11.14.
//  Copyright (c) 2014 Pavel Litvinko. All rights reserved.
//

import Foundation
import ExSwift

class SwiftComment: Statement {
    
    override func test(line: String, reader: StreamReader) -> Bool {
        return isSingleLineComment(line) || isMultilineComment(line, reader)
    }
    
    func isSingleLineComment(line: String) -> Bool{
        // \/\/
        return line =~ "\\/\\/"
    }
    
    func isMultilineComment(line: String, _ reader: StreamReader) -> Bool{
        // \/\*
        if line =~ "\\/\\*" {
            var endFound = false
            while let s = reader.nextLine() {
                //\*\/
                if s =~ "\\*\\/" {
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
