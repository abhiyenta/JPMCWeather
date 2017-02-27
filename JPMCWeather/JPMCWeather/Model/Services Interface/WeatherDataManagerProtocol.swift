//
//  WeatherDataManagerProtocol.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 WeatherDataManagerProtocol defines database access contract for clients. A Interface which declares the methods related accessing underlying data store .
 
 Classes can confirm to this protocol and provide various concrete implemenrations i.e. (Core Data, Sqlite, UserDefaults...etc).
 */


import Foundation

enum WeatherDBError:Error{
    case couldNotOpenDB
    case currptedDB
    case accessDenied
    case noSavedSearch
    case serializationFailed
}

enum WeatherDBResultType<T,E>{
    case success(T)
    case failure(E)
}

typealias WeatherDBResult = WeatherDBResultType<Weather,WeatherDBError>

protocol WeatherDataManagerProtocol {
    /**
      Gives last searched weather by the user from DB.
     - Returns: Weather object for last searched city.
     */
    func lastSearchedWeather() -> WeatherDBResult
    
    /**
     Sets last searched weather to DB.
     */
    func setLastSearchedWeather(weather: Weather)

}
