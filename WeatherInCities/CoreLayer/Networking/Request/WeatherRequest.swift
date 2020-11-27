//
//  WeatherRequest.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

class WeatherRequest: WeatherRequestProtocol {
    
    // https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true
    
    private func urlComponents(lat: String, lon: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.weather.yandex.ru"
        urlComponents.path = "/v2/forecast/"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "extra", value: "true"),
            URLQueryItem(name: "lang", value: "ru_RU")]
        
        return urlComponents.url
    }
    
    func urlRequest(lat: String, lon: String) -> URLRequest? {

        guard let url = urlComponents(lat: lat, lon: lon) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("14dfa846-4ee2-490c-90b8-d94e90654778", forHTTPHeaderField: "X-Yandex-API-Key")
        request.timeoutInterval = 60.0
        print("WeatherRequest")
        return request
    }
}
