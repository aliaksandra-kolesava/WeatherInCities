//
//  ConfigurableView.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 28.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol ConfigurableView {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
