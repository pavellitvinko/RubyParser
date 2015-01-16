//
//  StreamReader.swift
//  parser
//
//  Created by Pavel Litvinko on 14.10.14.
//  Copyright (c) 2014 pavellitvinko. All rights reserved.
//

import Cocoa
import Foundation

class StreamReader  {
    
    let encoding: UInt
    let chunkSize: Int
    
    var fileHandle: NSFileHandle!
    let buffer: NSMutableData = NSMutableData()
    let delimData: [NSData] = [NSData]()
    var atEof: Bool = false
    
    init(path: String, delimiters: [String] = ["\n"], encoding : UInt = NSUTF8StringEncoding, chunkSize : Int = 4096) {
        self.chunkSize = chunkSize
        self.encoding = encoding
        
        fileHandle = NSFileHandle(forReadingAtPath: path)
        assert(fileHandle != nil) // returning nil in an initializer is not (yet) supported
        buffer = NSMutableData(capacity: chunkSize)!
        
        // Create NSData array containing the line delimiters
        for delimiter in delimiters {
            delimData.append(delimiter.dataUsingEncoding(NSUTF8StringEncoding)!)
        }
    }
    
    deinit {
        self.close()
    }
    
    /// Return next line, or nil on EOF.
    func nextLine() -> String? {
        var line = readLine()
        while (line != nil) && (line!.isEmpty) {
            line = readLine()
        }
        return line
    }
    
    func readLine() -> String? {
        
        if atEof {
            return nil
        }
        
        var range = NSMakeRange(NSNotFound, 0)
        var i = 0;
        
        if buffer.length > 0 {
            while i < delimData.count && range.location == NSNotFound{
                range = buffer.rangeOfData(delimData[i], options: NSDataSearchOptions(0), range: NSMakeRange(0, buffer.length))
                i++
            }
        }
        
        // Read data chunks from file until one of the line delimiters is found:
        while range.location == NSNotFound {
            var tmpData: NSData = fileHandle.readDataOfLength(chunkSize)
            if  tmpData.length == 0 {
                // EOF or read error.
                atEof = true
                if buffer.length > 0 {
                    // Buffer contains last line in file (not terminated by delimiter).
                    let line = NSString(data: buffer, encoding: encoding);
                    buffer.length = 0
                    return line
                }
                // No more lines.
                return nil
            }
            buffer.appendData(tmpData)
            
            var i = 0;
            while i < delimData.count && range.location == NSNotFound{
                range = buffer.rangeOfData(delimData[i], options: NSDataSearchOptions(0), range: NSMakeRange(0, buffer.length))
                i++
            }
        }
        
        // Convert complete line (excluding the delimiter) to a string:
        let line = NSString(data: buffer.subdataWithRange(NSMakeRange(0, range.location)),
            encoding: encoding)
        // Remove line (and the delimiter) from the buffer:
        buffer.replaceBytesInRange(NSMakeRange(0, range.location + range.length), withBytes: nil, length: 0)
        
        return line
    }
    
    /// Start reading from the beginning of file.
    func rewind() -> Void {
        fileHandle.seekToFileOffset(0)
        buffer.length = 0
        atEof = false
    }
    
    /// Close the underlying file. No reading must be done after calling this method.
    func close() -> Void {
        if fileHandle != nil {
            fileHandle.closeFile()
            fileHandle = nil
        }
    }
}