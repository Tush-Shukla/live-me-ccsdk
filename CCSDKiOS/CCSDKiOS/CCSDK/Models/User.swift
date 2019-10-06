//
//  User.swift
//  CCSDKiOS
//
//  Created by Abdul Wahib on 2/6/19.
//  Copyright © 2019 Code Clobber. All rights reserved.
//

import Foundation

class User {
    
    public enum TYPE: String {
        case Normal = "normal"
        case Manager = "manager"
    }
    
    public var type : String?
    public var logins : Int?
    public var isBanned : Bool?
    public var _id : String?
    public var name : String?
    public var email : String?
    public var createdOn : String?
    public var updatedOn : String?
    public var token : String?
    public var lastVisited : String?
    public var imageUrl: String?
    public var status: String?
    
    // Bar Finder Fields
    public var bar : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    public init(){}
    
    required public init?(dictionary: NSDictionary) {
        
        type = dictionary["type"] as? String
        logins = dictionary["logins"] as? Int
        isBanned = dictionary["isBanned"] as? Bool
        _id = dictionary["_id"] as? String
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        createdOn = dictionary["createdOn"] as? String
        updatedOn = dictionary["updatedOn"] as? String
        token = dictionary["token"] as? String
        lastVisited = dictionary["lastVisited"] as? String
        imageUrl = dictionary["imageUrl"] as? String
        status = dictionary["status"] as? String
        
        // Bar Finder Fields
        bar = dictionary["bar"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.logins, forKey: "logins")
        dictionary.setValue(self.isBanned, forKey: "isBanned")
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.createdOn, forKey: "createdOn")
        dictionary.setValue(self.updatedOn, forKey: "updatedOn")
        dictionary.setValue(self.token, forKey: "token")
        dictionary.setValue(self.lastVisited, forKey: "lastVisited")
        dictionary.setValue(self.imageUrl, forKey: "imageUrl")
        dictionary.setValue(self.status, forKey: "status")
        
        // Bar Finder Fields
        dictionary.setValue(self.bar, forKey: "bar")
        
        return dictionary
    }
    
}
