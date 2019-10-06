//
//  Bar.swift
//  Bar Finder
//
//  Created by Abdul Wahib on 2/17/19.
//  Copyright © 2019 Nova Storm. All rights reserved.
//

import Foundation

public class Bar {
    public var _id : String?
    public var offers = [Offer]()
    public var name : String?
    public var address : String?
    public var phone : String?
    public var coordinates = [Double]()
    public var creator : String?
    public var createdOn : String?
    public var updatedOn : String?
    
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [Bar]
    {
        var models:[Bar] = []
        for item in array
        {
            models.append(Bar(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["offers"] != nil) {
            offers = Offer.modelsFromDictionaryArray(array: dictionary["offers"] as! NSArray)            
        }
        name = dictionary["name"] as? String
        address = dictionary["address"] as? String
        phone = dictionary["phone"] as? String
        if (dictionary["coordinates"] != nil) {
            coordinates = dictionary["coordinates"] as? [Double] ?? [0.0, 0.0]
        }
        creator = dictionary["creator"] as? String
        createdOn = dictionary["createdOn"] as? String
        updatedOn = dictionary["updatedOn"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.address, forKey: "address")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.coordinates, forKey: "coordinates")
        dictionary.setValue(self.creator, forKey: "creator")
        dictionary.setValue(self.createdOn, forKey: "createdOn")
        dictionary.setValue(self.updatedOn, forKey: "updatedOn")
        
        return dictionary
    }
}
