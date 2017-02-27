//
//  Weather+CoreDataClass.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 This class encapsulates Weather model. We could define translation/validation logic here
*/


import Foundation
import CoreData


public struct Weather {
    
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
}
