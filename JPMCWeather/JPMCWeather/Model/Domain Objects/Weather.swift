//
//  Weather+CoreDataClass.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 This class encapsulates Weather model. Currently its using Arhive/unarhive for persistent however same could be MangedObject for CoreData based persistent/storage
 We could also define translation/validation logic here
*/


import Foundation
import CoreData


public class Weather: NSObject,  NSCoding {
    
    let currentTemp: Float
    let icon: String
    let desc: String
    let type: String
    let city: String
    
    init(currentTemp: Float, icon: String, desc: String, type: String, city: String) {
        self.currentTemp = currentTemp
        self.icon = icon
        self.desc = desc
        self.type = type
        self.city = city
    }
    
    public required init(coder decoder: NSCoder) {
        self.currentTemp = decoder.decodeFloat(forKey: "currentTemp")
        self.icon = decoder.decodeObject(forKey: "icon") as? String ?? ""
        self.desc = decoder.decodeObject(forKey: "desc") as? String ?? ""
        self.type = decoder.decodeObject(forKey: "type") as? String ?? ""
        self.city = decoder.decodeObject(forKey: "city") as? String ?? ""
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(currentTemp, forKey: "currentTemp")
        coder.encode(icon, forKey: "icon")
        coder.encode(desc, forKey: "desc")
        coder.encode(type, forKey: "type")
        coder.encode(city, forKey: "city")
    }
}
