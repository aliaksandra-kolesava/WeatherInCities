//
//  CityInfoModel.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

protocol CityInfoModelProtocol {
    var weatherInfo: WeatherModel? { get set }
    func loadData(lat: String, lon: String)
    func loadImage(icon: String, completion: @escaping (SVGKImage?) -> Void)
    
}

protocol CityInfoDelegate: class {
    func loadComplited()
}

class CityInfoModel: CityInfoModelProtocol {
    
    let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    weak var delegate: CityInfoDelegate?
    var weatherInfo: WeatherModel?
    
    func loadData(lat: String, lon: String) {
        networkManager.loadData(lat: lat, lon: lon) { (weather, error) in
            if let error = error {
                print(error)
                return
            }
            guard let weather = weather else { return }
            self.weatherInfo = weather
            self.delegate?.loadComplited()
        }
    }
    
    func loadImage(icon: String, completion: @escaping (SVGKImage?) -> Void) {
        let image = networkManager.checkCache(icon: icon)
        guard let picture = image else {
            self.networkManager.loadImage(icon: icon) { (loadingImage, error) in
                if let error = error {
                    print(error)
                    return
                }
                guard let loadingImage = loadingImage else { return }
                self.networkManager.saveToCache(icon: icon, picture: loadingImage)
                completion(loadingImage)
            }
            return
        }
        completion(picture)
    }
}
