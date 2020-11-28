//
//  NetworkManager.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func loadData(lat: String, lon: String, completionHandler: @escaping (WeatherModel?, String?) -> Void)
    func loadImage(icon: String, completion: @escaping (UIImage?, String?) -> Void)
    func checkCache(icon: String) -> UIImage?
    func saveToCache(icon: String, picture: UIImage)
}

class NetworkManager: NetworkManagerProtocol {
    
    let requestSender: RequestSenderProtocol
    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
    }
    
    var cache = NSCache<NSString, UIImage>()
    
    func loadData(lat: String, lon: String, completionHandler: @escaping (WeatherModel?, String?) -> Void) {
        let requestConfig = RequestFactory.Request.newWeatherConfig()
        requestSender.send(lat: lat, lon: lon, icon: nil, requestConfig: requestConfig) { (result: Result<WeatherModel>) in
              switch result {
              case .success(let weatherModel):
                  completionHandler(weatherModel, nil)
              case .error(let error):
                  completionHandler(nil, error)
            }
        }
    }
    
    func loadImage(icon: String, completion: @escaping (UIImage?, String?) -> Void) {
        let requestConfig = RequestFactory.Request.newWeatherImage()
        requestSender.send(lat: nil, lon: nil, icon: icon, requestConfig: requestConfig) { (result: Result<UIImage>) in
              switch result {
                  case .success(let pictures):
                      completion(pictures, nil)
                  case .error(let error):
                      completion(nil, error)
            }
        }
    }
    
    func checkCache(icon: String) -> UIImage? {
           if let cache = cache.object(forKey: icon as NSString) {
               return cache
           }
           return nil
       }
       
       func saveToCache(icon: String, picture: UIImage) {
           cache.setObject(picture, forKey: icon as NSString)
       }
}
