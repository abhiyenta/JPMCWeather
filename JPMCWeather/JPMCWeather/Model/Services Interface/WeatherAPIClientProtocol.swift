//
//  WeatherAPIClientProtocol.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
  WeatherAPIClientProtocol defines weather API access contract for clients. A Interface which declares the methods related to fetching weather data from weather web services.
 
  Classes can confirm to this protocol and provide various concrete implemenrations i.e. (REST, SOAP, ...etc).
 */


import Foundation

enum WeatherAPIError: Error{
    case noData
    case invalidURL(urlString: String)
    case invalidSeachTerm(searchTerm: String)
    case otherError(error: Swift.Error)
    case deserialisingFailed
}

enum WeatherAPIResultType<T,E>{
    case success(T)
    case failure(E)
}

typealias WeatherAPIResult = WeatherAPIResultType<String, WeatherAPIError>

typealias WeatherAPIComplitionHandler = (WeatherAPIResult) -> Void

protocol WeatherAPIClientProtocol {
    /**
     Asynchronous Fetch weather record for given search term from weather serivce.
     
     - Parameter city: city for which weather record needs to fetch.
     - Parameter complitionHandler: called upon getting response from service
     - Returns: nothing.
     */
    func fetchWeather(searhTerm: String, complitionHandler: @escaping WeatherAPIComplitionHandler)
}

