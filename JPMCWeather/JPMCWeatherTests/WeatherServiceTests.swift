//
//  WeatherServiceTests.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/27/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
    Covering only basic integration tests here for WeatherService
 */

import Foundation

import XCTest
@testable import JPMCWeather

class WeatherServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Require refactoring(e.g. common SUT) to avoid duplication.
    //In acutal app this would be replaced by MOCK objects for collabrators to avoid actual service calls
    func test_FetchingForWeather_ReturnsWeatherObject() {
        //given / setup
        let weatherParser = WeatherParserJSON()
        let weatherAPIClient = WeatherAPIClientRest()
        let dbManager = WeatherDataManager()
        
        let SUT = WeatherService(parser: weatherParser, apiClient: weatherAPIClient, dbManager:dbManager)
        let weatherFetchExpectation = expectation(description: "AsyncWeatherFetch")

        //when/ excecute
        SUT.fetchWeather(city: "Plano", complitionHandler: { (WeatheServiceFetchResult) in
            switch WeatheServiceFetchResult {
            case let .success(weather):
                //then //assert
                XCTAssertNotNil(weather, "Weather data not received")
            case let .failure(error):
                XCTAssertNil(error, "Fetch Error occured")

            }
            weatherFetchExpectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "Error occured")
        }
        
    }
    
    //Require refactoring(e.g. common SUT) to avoid duplication.
    //In acutal app this would be replaced by MOCK objects for collabrators to avoid actual service calls
    func test_GettingWeather_ReturnsExptedFields() {
        //given
        let weatherParser = WeatherParserJSON()
        let weatherAPIClient = WeatherAPIClientRest()
        let dbManager = WeatherDataManager()
        
        let SUT = WeatherService(parser: weatherParser, apiClient: weatherAPIClient, dbManager:dbManager)
        let weatherFetchExpectation = expectation(description: "AsyncWeatherFetch")

        //when/ excecute
        SUT.fetchWeather(city: "Plano", complitionHandler: { (WeatheServiceFetchResult) in
            switch WeatheServiceFetchResult {
            case let .success(weather):
                //then //assert
                XCTAssertNotNil(weather.city, "City name not found")
                XCTAssertNotNil(weather.desc, "description not found")
                XCTAssertNotNil(weather.currentTemp, "Temperature not found ")
                XCTAssertNotNil(weather.type, "type not found")
            case let .failure(error):
                XCTAssertNil(error, "Fetch Error occured")
            }
            weatherFetchExpectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "Error occured")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
