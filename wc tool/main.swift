//
//  main.swift
//  wc tool
//
//  Created by Leo Magtibay on 8/26/25.
//

import Foundation

//var x = 0


//let file = "/Users/leomagtibay/Downloads/test.txt"


/*
do {
    let contents = try String(contentsOfFile: file , encoding: .utf8)
    print(contents)
} catch {
    print("Error reading file \(file): \(error)")
}
 */
//print("read your line!! hehe : \(y)")

/*
if let y = readLine() {
    print("read your line!! hehe: \(y)")
} else {
    print("couldn't read your line :(")
}
 */

if let input = readLine() {
    
   let chars = Array(input)
    
    /*
    if chars[0] == "c" && chars[1] == "c" && chars[2] == "w" && chars[3] == "c" {
        print("good job dumbass")
    }
     */
    
    // use an array that works like a stack
    // 1st element is the ccwc
    // 2nd element is the command
    // 3rd element is filename
    var stack:[String] = []
    
    var i: Int = 0
    
    var string = ""
    for char in chars {

        if char == " " {
            stack.append(string)
            i += 1 // move one character, not using space char
            //print(string)
            string = "" // refresh the string
        } else {
            i += 1
            string.append(char)
        }

        
    }
    stack.append(string)
    
    if stack.count == 3 {
        if stack[0] == "ccwc" {
            let file = "/Users/leomagtibay/Documents/Leo Apps/wc tool/wc tool/\(stack[2])"
            
            if stack[1] == "-c" {
                
                do {
                    let attrs = try FileManager.default.attributesOfItem(atPath: file)
                    if let fileSize = attrs[.size] as? NSNumber {
                        print("\(fileSize.intValue) \(stack[2])")
                    }
                } catch {
                    print("Error reading file \(file): \(error)")
                }
                
            } else if stack[1] == "-l" {
                do {
                    /*
                     let fileURL = URL(fileURLWithPath: file)
                     var lineCount = 0
                     let fileHandle = try FileHandle(forReadingFrom: fileURL)
                     
                     for try await line in fileHandle.bytes.lines {
                     lineCount += 1
                     }
                     */
                    //let contents = try String(contentsOfFile: file, encoding: .utf8)
                    //print(contents)
                    //let lines = contents.split(separator: "\r\n")
                    print("\(try lineCount(atPath: file)) \(stack[2])")
                    //let lines = contents.split(whereSeparator: \.isNewline)
                    //print(lines)
                    
                    //print("\(lines.count) \(stack[2])")
                    
                } catch {
                    print("Error counting lines: \(error)")
                }
            } else if stack[1] == "-w" {
                /*
                 let text = try String(contentsOfFile: file, encoding: .utf8)
                 var count = 0
                 text.enumerateSubstrings(in: text.startIndex..<text.endIndex, options: .byWords) { _, _, _, _ in
                 count += 1
                 }
                 print("Word count: \(count)")
                 */
                let text = try String(contentsOfFile: file, encoding: .utf8)
                let words = text.split {$0.isWhitespace || $0.isNewline}
                
                print("\(words.count) \(stack[2])")
            } else if stack[1] == "-m" {
                let text = try String(contentsOfFile: file, encoding: .utf8)
                
                print("\(text.unicodeScalars.count) \(stack[2])")
                
            }
            
            
        } else {
            print("command not found")
        }
    } else if stack.count == 2 {
        if stack[0] == "ccwc" {
            let file = "/Users/leomagtibay/Documents/Leo Apps/wc tool/wc tool/\(stack[1])"
            do {
                let attrs = try FileManager.default.attributesOfItem(atPath: file)
                let text = try String(contentsOfFile: file, encoding: .utf8)
                let words = text.split {$0.isWhitespace || $0.isNewline }
                if let fileSize = attrs[.size] as? NSNumber {
                    print("\(fileSize.intValue) \(try lineCount(atPath: file)) \(words.count) \(stack[1])")
                }
            } catch {
                print("Error reading file \(file): \(error)")
            }
            
        } else {
            print("command not found")
        }
    } else if stack.count == 5 {
        if stack[0] == "cat" {
            let file = "/Users/leomagtibay/Documents/Leo Apps/wc tool/wc tool/\(stack[1])"
            if stack[4] == "-c" {
                
                do {
                    let attrs = try FileManager.default.attributesOfItem(atPath: file)
                    if let fileSize = attrs[.size] as? NSNumber {
                        print("\(fileSize.intValue)")
                    }
                } catch {
                    print("Error reading file \(file): \(error)")
                }
                
            } else if stack[4] == "-l" {
                do {

                    print("\(try lineCount(atPath: file)) ")
    
                    
                } catch {
                    print("Error counting lines: \(error)")
                }
            } else if stack[4] == "-w" {
 
                let text = try String(contentsOfFile: file, encoding: .utf8)
                let words = text.split {$0.isWhitespace || $0.isNewline}
                
                print("\(words.count) ")
            } else if stack[4] == "-m" {
                let text = try String(contentsOfFile: file, encoding: .utf8)
                
                print("\(text.unicodeScalars.count) ")
                
            }
        } else {
            print("command not found")
        }
    } else {
        print("invalid entry")
    }
    
}

func lineCount(atPath path: String) throws -> Int {
    let s = try String(contentsOfFile: path, encoding: .utf8)
    var count = 0
    s.enumerateSubstrings(in: s.startIndex..<s.endIndex, options: .byLines) { _, _, _, _ in
        count += 1
    }
    return count // 0 for empty file, correct for mixed line endings
}
