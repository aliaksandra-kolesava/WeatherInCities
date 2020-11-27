//
//  NetworkManager.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func loadData(lat: String, lon: String, completionHandler: @escaping (WeatherModel?, String?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    let requestSender: RequestSenderProtocol
    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
    }
    
    func loadData(lat: String, lon: String, completionHandler: @escaping (WeatherModel?, String?) -> Void) {
        let requestConfig = RequestFactory.Request.newWeatherConfig()
        requestSender.send(lat: lat, lon: lon, requestConfig: requestConfig) { (result: Result<WeatherModel>) in
              switch result {
              case .success(let weatherModel):
                  completionHandler(weatherModel, nil)
              case .error(let error):
                  completionHandler(nil, error)
            }
        }
    } 
}
