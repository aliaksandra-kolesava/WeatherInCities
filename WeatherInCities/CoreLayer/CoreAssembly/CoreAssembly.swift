//
//  CoreAssembly.swift
//  WeatherInCities
//
//  Created by Александра Колесова on 27.11.2020.
//  Copyright © 2020 Александра Колесова. All rights reserved.
//

import Foundation

protocol CoreAssemblyProtocol {
    var requestSender: RequestSenderProtocol { get }
}

class CoreAssembly: CoreAssemblyProtocol {
    var requestSender: RequestSenderProtocol = RequestSender()
}
