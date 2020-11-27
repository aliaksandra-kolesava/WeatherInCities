//
//  WeatherRequestProtocol.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol WeatherRequestProtocol {
    func urlRequest(lat: String, lon: String) -> URLRequest?
}
