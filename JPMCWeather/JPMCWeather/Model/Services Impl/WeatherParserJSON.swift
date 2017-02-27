//
//  WeatherParserJSON.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

import Foundation

class WeatherParserJSON: WeatherParserProtocol {
    
    func fillWeatherFrom(formatString: String) -> ParseResult {

        //convert JSON string to object
        guard let jsonDict = formatString.parseJSONString as? [String: Any] else{
            return .failure(WeatherParsingError.deserialisingFailed)
        }
        
        //parse temparature
        guard let tempInfo = jsonDict["main"] as? [String: Any],
            let temp = tempInfo["temp"] as? Float else {
                return .failure(WeatherParsingError.missingData("temp"))
        }
        
        //parse weather subobject
        guard let weatherDict = jsonDict["weather"] as? [[String: Any]] else{
            return .failure(WeatherParsingError.wrongFormat)
        }
        
        //parse type
        guard let type = weatherDict[0]["main"] as? String else {
                return .failure(WeatherParsingError.missingData("type"))
        }
        
        //parse description
        guard let desc = weatherDict[0]["description"] as? String else {
            return .failure(WeatherParsingError.missingData("description"))
        }
        
        //parse icon
        guard let icon = weatherDict[0]["icon"] as? String else {
            return .failure(WeatherParsingError.missingData("icon"))
        }
        
        //parse city
        guard let city = jsonDict["name"] as? String else {
            return .failure(WeatherParsingError.missingData("name"))
        }
        
        //here we have full weather object
        let weather = Weather(currentTemp: temp, icon: icon, desc: desc, type: type, city: city)
        return .success(weather)
    }
}
