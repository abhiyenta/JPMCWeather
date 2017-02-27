//
//  WeatherParserProtocol.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 WeatherParserProtocol defines parsing contract for clients. A Interface which declares the methods related to mapping the xml/json/..etc basic types to Weather model object .
 
 Classes can confirm to this protocol and provide various concrete implemenrations i.e. (json -> weather, xml -> weather...etc).
 */


import Foundation

enum WeatherParsingError:Error{
    case deserialisingFailed
    case invalidData
    case missingData(String)
    case wrongFormat
}

enum ParseResultType<T,E>{
    case success(T)
    case failure(E)
}

typealias ParseResult = ParseResultType<Weather, WeatherParsingError>

protocol WeatherParserProtocol {
    /**
     Given a formated JSON/XML string returns a filled Weather object from it.
     
     - Parameter formatString: JSON/XML string to parse from.
     - Returns: Filled Weather object.
     */
    func fillWeatherFrom(formatString: String) -> ParseResult
}

