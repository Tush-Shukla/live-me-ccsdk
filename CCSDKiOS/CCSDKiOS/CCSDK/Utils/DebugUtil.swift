//
//  DebugUtil.swift
//

import Foundation

func Log(message: String, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    print("Message: \(message) | File: \(file) | Function: \(function) | Line: \(line)")
    #else
    print(message)
    #endif
}
