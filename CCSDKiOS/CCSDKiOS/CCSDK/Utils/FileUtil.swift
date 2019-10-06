//
//  FileUtil.swift
//

import Foundation

class FileUtil {
    static func readPlist(name: String) -> NSDictionary? {
        return NSDictionary(contentsOfFile: Bundle.main.path(forResource: name, ofType: "plist")!)
    }
}
