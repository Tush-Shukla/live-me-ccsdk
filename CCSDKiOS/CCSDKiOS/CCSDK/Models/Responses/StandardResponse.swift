//
//  StandardResponse.swift
//

import Foundation

class StandardResponse {
    
    public var status : Int = 0
    public var message : String = ""
    public var data: Any?
    
    required public init?(dictionary: NSDictionary) {
        
        status = dictionary[AppConstant.Response.STATUS] as? Int ?? 0
        message = dictionary[AppConstant.Response.MESSAGE] as? String ?? ""
        data = dictionary[AppConstant.Response.DATA]
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.data, forKey: "data")
        
        return dictionary
    }

    
}
