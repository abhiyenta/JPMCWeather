//
//  WeatherDataManager.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 Concrete implementation of WeatherDataManagerProtocol for Archive/Un-Archive based storage
 */

import Foundation

class WeatherDataManager : WeatherDataManagerProtocol{
    
    let userDefaults: UserDefaults!
    
    init() {
        userDefaults = UserDefaults()
    }
    
    func lastSearchedWeather() -> WeatherDBResult{
        //make sure we get data for our store key
        guard let lastSearchedCity = userDefaults.data(forKey: Constants.WeatherApi.lastSearchedCityKey) else {
            return .failure(WeatherDBError.noSavedSearch)
        }
        
        //make sure unarhive was successful
        guard let weather = NSKeyedUnarchiver.unarchiveObject(with: lastSearchedCity) as? Weather else{
            return .failure(WeatherDBError.noSavedSearch)
        }
        return .success(weather)
    }
    
    func setLastSearchedWeather(weather: Weather){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: weather)
        userDefaults.set(encodedData, forKey: Constants.WeatherApi.lastSearchedCityKey)
    }
}
