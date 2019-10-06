//
//  StringExtension.swift
//

import Foundation

extension String {
    func getHTMLRendered() -> NSAttributedString? {
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            let attributedString = try NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
            return attributedString
        }catch {
            return nil
        }        
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    var random: String {
        return "\(Date().timeIntervalSince1970)"
    }
    
}
