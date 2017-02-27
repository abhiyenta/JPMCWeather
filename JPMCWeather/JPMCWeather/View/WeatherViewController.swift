//
//  WeatherViewController.swift
//  JPMCWeather
//
//  Created by MOSO33 on 2/26/17.
//  Copyright © 2017 JPMC. All rights reserved.
//

/*
 Represents weather app UI. We could use MVVM to put translation related code to map model to UI elements
 */

import Foundation
import UIKit

class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    //UI elements
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temeratureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //weather service for all weather related information
    var weatherService:WeatherService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.hidesWhenStopped = true;
        loadLastSearchedWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //# MARK: - Search Bar Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text{
            showActivityIndicator()
            fetchWeather(searchTerm: searchTerm)
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    //Keyboard will make sure at least one search character
    func fetchWeather(searchTerm:String){
        weatherService?.fetchWeather(city: searchTerm, complitionHandler: weatherSearchComplitionHandler)
    }
    
    //complition handler for search and local db fetch
    func weatherSearchComplitionHandler(weatheServiceFetchResult: WeatheServiceFetchResult){
        switch weatheServiceFetchResult {
        case let .success(weather):
            self.relaodWeatherData(weather: weather)
        case let .failure(error):
            self.hideActivityIndicator()
            print(error) //inform user about error. Could use alertcontroller or something else
        }
    }
    
    //first load the last searched weather into UI and then make service call to fetch latest weather status
    //This way we can provide Offline support
    func loadLastSearchedWeather(){
        weatherSearchComplitionHandler(weatheServiceFetchResult: (weatherService?.fetchLastSearchedWeather(complitionHandler: weatherSearchComplitionHandler))!)
    }
    
    //Update UI
    func relaodWeatherData(weather: Weather){
        DispatchQueue.main.async {
            self.descriptionLabel.text = weather.desc
            self.cityLabel.text = weather.city
            self.temeratureLabel.text = "\(self.convertKelvinToFahrenheit(kelvinTemp: weather.currentTemp))˚F" //we can user MVVM to move this translation code for Kelvin fahrenheit, degree vs celsius and other temp units
            self.iconImageView.getImageFromURL(urlString: "\(Constants.WeatherApi.iconBaseURL)" + "\(weather.icon).png")
            self.hideActivityIndicator()
        }
    }
    
    //this is hardcoded translation logic which can move into viewmodel(MVVM)
    func convertKelvinToFahrenheit(kelvinTemp: Float) -> Float{
        return (kelvinTemp * 9/5) - 459.67
    }
    
    func showActivityIndicator(){
        activityIndicator.isHidden  = false
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator(){
        self.activityIndicator.isHidden  = true
        self.activityIndicator.stopAnimating()
    }
}
