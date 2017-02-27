//
//  ObjectGraphConfigurator.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 This class responsible for creating fully configured object graph of application. Much like dependency injection container(but Manual)
 */

import Foundation

final class ObjectGraphConfigurator {
    
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: ObjectGraphConfigurator = ObjectGraphConfigurator()
    
    /**
     Creates configured object graph of WeatherViewController.
     - Returns: Configured WeatherViewController object.
     */
    func weatherViewController() -> WeatherViewController {
        let weatherParser = WeatherParserJSON()
        let weatherAPIClient = WeatherAPIClientRest()
        let dbManager = WeatherDataManager()
        
        let weatherService = WeatherService(parser: weatherParser, apiClient: weatherAPIClient, dbManager:dbManager)
        
        let weatherViewController = WeatherViewController(nibName: nil, bundle: nil)
        weatherViewController.weatherService = weatherService
        
        return weatherViewController
    }
}
