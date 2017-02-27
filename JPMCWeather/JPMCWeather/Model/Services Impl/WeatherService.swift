//
//  WeatherService.swift
//  JPWeather
//
//  Created by MOSO33 on 2/25/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

import Foundation

enum WeatheServiceResultType<T, E> {
    case success(T)
    case failure(E)
}

typealias WeatheServiceFetchResult = WeatheServiceResultType<Weather, Error>

typealias WeatheServiceResponse = (WeatheServiceFetchResult) -> Void

class WeatherService{
    
    let parser:WeatherParserProtocol
    let apiClient:WeatherAPIClientProtocol
    var dbManager:WeatherDataManagerProtocol
    
    init(parser: WeatherParserProtocol, apiClient: WeatherAPIClientProtocol, dbManager: WeatherDataManagerProtocol) {
        self.parser = parser
        self.apiClient = apiClient
        self.dbManager = dbManager
    }
    
    /**
     Given a search city returns a Weather object.
     
     - Parameter city: city for which weather is being searched.
     - Parameter complitionHandler: closure which called upon search complition.
     */
    
    func fetchWeather(city: String, complitionHandler:@escaping WeatheServiceResponse) {
        
        apiClient.fetchWeather(searhTerm: city) { (apiResult) in
            switch apiResult{
            case let .success(weatherJSONString):
                let parseResult = self.parser.fillWeatherFrom(formatString: weatherJSONString)
                switch parseResult{
                case let .success(weather):
                    self.dbManager.setLastSearchedWeather(weather: weather) //save last search into DB for offline/auto load support
                    complitionHandler(.success(weather))
                case let .failure(error):
                    switch error{
                    default:
                        complitionHandler(.failure(error))
                    }
                }
            case let .failure(error):
                switch error{
                default:
                    complitionHandler(.failure(error))
                }
            }
        }
    }
        
    /**
     Fetch last searched city's Weather from DB.
     
     - Parameter complitionHandler: closure which called upon search complition from API.
     - Returns WeatheServiceFetchResult which either has last searched weather OR any error
     */
    
    func fetchLastSearchedWeather(complitionHandler:@escaping WeatheServiceResponse) -> WeatheServiceFetchResult{
        let lastSearchedCityResult = dbManager.lastSearchedWeather() //retrive last search into DB for offline/auto load support
        switch lastSearchedCityResult {
        case let .success(weather):
            fetchWeather(city: weather.city, complitionHandler: complitionHandler)
            return .success(weather)
        case let .failure(error):
            return .failure(error)
        }
    }
}
