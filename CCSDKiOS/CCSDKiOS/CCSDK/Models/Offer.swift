//
//  Offer.swift
//  Bar Finder
//
//  Created by Abdul Wahib on 3/2/19.
//  Copyright © 2019 Nova Storm. All rights reserved.
//

import Foundation

public class Offer {
	public var title : String?
	public var from : String?
	public var to : String?
	public var description : String?
	public var image : String?
    public var bar : Bar?
	public var createdOn : String?
	public var updatedOn : String?
    public var toDate: Date?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Offer_list = Offer.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Offer Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Offer]
    {
        var models:[Offer] = []
        for item in array
        {
            models.append(Offer(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let Offer = Offer(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Offer Instance.
*/
	required public init?(dictionary: NSDictionary) {

		title = dictionary["title"] as? String
		from = dictionary["from"] as? String
		to = dictionary["to"] as? String
		description = dictionary["description"] as? String
		image = dictionary["image"] as? String
        if let dic = dictionary["bar"] as? NSDictionary {
            bar = Bar(dictionary: dic)
        }
		createdOn = dictionary["createdOn"] as? String
		updatedOn = dictionary["updatedOn"] as? String
        
        if let to = to {
            toDate = Date.dateFromString(string: to, format: AppConstant.Response.DATE_FORMAT)
        }        
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.from, forKey: "from")
		dictionary.setValue(self.to, forKey: "to")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.bar?.dictionaryRepresentation(), forKey: "bar")
		dictionary.setValue(self.createdOn, forKey: "createdOn")
		dictionary.setValue(self.updatedOn, forKey: "updatedOn")

		return dictionary
	}
    
    var isExpired: Bool {
        guard let date = toDate else {return false}
        return date < Date()
    }

}
