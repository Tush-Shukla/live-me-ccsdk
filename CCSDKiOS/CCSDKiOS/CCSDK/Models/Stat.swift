//
//  Stat.swift
//  Bar Finder
//
//  Created by Abdul Wahib on 2/17/19.
//  Copyright © 2019 Nova Storm. All rights reserved.
//

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Stat {
	public var views = [String]()
	public var peopleComing = [String]()
	public var lookingForDiscount = [String]()
	public var _id : String?
	public var date : String?
	public var bar : String?
	public var createdOn : String?
	public var updatedOn : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let stat_list = Stat.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Stat Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Stat]
    {
        var models:[Stat] = []
        for item in array
        {
            models.append(Stat(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

        views = dictionary["views"] as? [String] ?? []
        peopleComing = dictionary["peopleComing"] as? [String] ?? []
        lookingForDiscount = dictionary["lookingForDiscount"] as? [String] ?? []
        
		_id = dictionary["_id"] as? String
		date = dictionary["date"] as? String
		bar = dictionary["bar"] as? String
		createdOn = dictionary["createdOn"] as? String
		updatedOn = dictionary["updatedOn"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()
        dictionary.setValue(self.views, forKey: "views")
        dictionary.setValue(self.peopleComing, forKey: "peopleComing")
        dictionary.setValue(self.lookingForDiscount, forKey: "lookingForDiscount")
		dictionary.setValue(self._id, forKey: "_id")
		dictionary.setValue(self.date, forKey: "date")
		dictionary.setValue(self.bar, forKey: "bar")
		dictionary.setValue(self.createdOn, forKey: "createdOn")
		dictionary.setValue(self.updatedOn, forKey: "updatedOn")

		return dictionary
	}

}
