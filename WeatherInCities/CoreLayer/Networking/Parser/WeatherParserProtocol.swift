//
//  WeatherParserProtocol.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol WeatherParserProtocol {
    associatedtype Model
    func parse(data: Data) -> Model?
}
