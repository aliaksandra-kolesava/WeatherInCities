//
//  RequestFactory.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

struct RequestFactory {
    struct Request {
        static func newWeatherConfig() -> RequestConfig<WeatherParser> {
            return RequestConfig<WeatherParser>(request: WeatherRequest(), parser: WeatherParser())
        }
    }
}
