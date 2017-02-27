//
//  WeatherAPIClientRest.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 Concrete implementation of WeatherAPIClientProtocol for REST based web services
 */

import Foundation

class WeatherAPIClientRest: WeatherAPIClientProtocol {
    
    func fetchWeather(searhTerm: String, complitionHandler: @escaping WeatherAPIComplitionHandler){
    
        //get credentials and construct end point
        let apiEndPoint = Constants.WeatherApi.serviceBaseUrl + "data/2.5/weather?q=\(searhTerm)&appid=\(Constants.WeatherApi.appID)"
        
        // make sure the string is URL encoded
        guard let apiEndPointWithPercentEscapes = apiEndPoint.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else{
            return complitionHandler(.failure(WeatherAPIError.invalidURL(urlString: apiEndPoint)))
        }
        
        // make sure the URL is valid
        guard let url = URL(string: apiEndPointWithPercentEscapes) else {
            return complitionHandler(.failure(WeatherAPIError.invalidURL(urlString: apiEndPoint)))
        }
        
        //construct request
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            //make sure data is received
            guard let data = data else {
                return complitionHandler(.failure(WeatherAPIError.noData))
            }
            // json data to string form// this will allow switching it to some other protocol like xml in future if required
            guard let convertedString = String(data: data, encoding: String.Encoding.utf8) else {
                return complitionHandler(.failure(WeatherAPIError.deserialisingFailed))
            }
            
            return complitionHandler(.success(convertedString))
        }.resume()
    }
}
